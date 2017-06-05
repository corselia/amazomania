require 'amazomania/scraping'

module ParseHtml
  include Scraping

  def parse_html(asin)
    @nokogiried_doc   = scraping(asin)
    @shop_names       = shop_names
    @prices           = prices
    @main_conditions  = main_conditions
    @sub_conditions   = sub_conditions
    @shipping_prices  = shipping_prices
    @amazon_points    = amazon_points
  end

  def shop_names
    seller_count = 0
    nodesets = @nokogiried_doc.xpath("//*/h3[@class='a-spacing-none olpSellerName']") # 浅くしないと Amazon のネイティブ出品 および Amazonプライム の場合が判別できない
    shop_names = []
    nodesets.each do |nodeset| # ネストがやや深い
      if nodeset.to_s.include?("seller") # to_s するのはとても荒い調べ方
        shop_name = @nokogiried_doc.xpath("//*/h3[@class='a-spacing-none olpSellerName']/span/a")[seller_count].inner_text
        shop_names.push(shop_name)
        seller_count += 1
      elsif nodeset.to_s.include?("amazon.co.jp/shops/") # Amazonアウトレット の場合
        shop_names.push("Amazonアウトレット")
      else
        shop_names.push("Amazon.co.jp") # Amazon のネイティブ出品 or Amazonプライム の場合
      end
    end
    shop_names
  end

  def prices
    nodesets = @nokogiried_doc.xpath("//*/span[@class='a-size-large a-color-price olpOfferPrice a-text-bold']")
    prices = []
    nodesets.each do |nodeset|
      prices.push(nodeset.inner_text.lstrip.gsub(/[^\d]/, ""))
    end
    prices
  end

  def main_conditions
    nodesets = @nokogiried_doc.xpath("//*/span[@class='a-size-medium olpCondition a-text-bold']")
    main_conditions = []
    nodesets.each do |nodeset|
      condition_tmp = nodeset.inner_text.gsub(" ", "").gsub(/\n/, "")
      if condition_tmp.to_s.include?("中古品") # to_s するのはとても荒い調べ方
        main_condition = "中古品"
      elsif
        main_condition = nodeset.inner_text.gsub(" ", "").strip
      end
      main_conditions.push(main_condition)
    end
    main_conditions
  end

  def sub_conditions
    nodesets = @nokogiried_doc.xpath("//*/span[@class='a-size-medium olpCondition a-text-bold']")
    sub_conditions = []
    nodesets.each do |nodeset|
      condition_tmp = nodeset.inner_text.gsub(" ", "").gsub(/\n/, "")
      if condition_tmp.to_s.include?("中古品") # to_s するのはとても荒い調べ方
        condition_tmp =~ /中古品\-(.*)/
        sub_condition = $1
      else
        sub_condition = "新品"
      end
      sub_conditions.push(sub_condition)
    end
    sub_conditions
  end

  def shipping_prices
    nodesets = @nokogiried_doc.xpath("//span[@class='a-color-secondary']")
    shipping_prices = []
    nodesets.each do |nodeset|
      if nodeset.to_s.include?("color: #990000;") # to_s するのはとても荒い調べ方
        next
      end
      if nodeset.to_s.include?("olpShippingPrice")
        shipping_price = nodeset.inner_text.chomp.gsub(" ", "").gsub(/(\r\n|\r|\n|\f)/,"")
        shipping_price = shipping_price.gsub(/[^\d]/, "")
        shipping_prices.push(shipping_price)
      else
        shipping_prices.push("0")
      end
    end
    shipping_prices
  end

  def amazon_points
    nodesets = @nokogiried_doc.xpath("//*/span[@class='a-color-secondary']")
    amazon_points = []
    next_nodeset_is_skipped = false
    nodesets.each do |nodeset|
      if next_nodeset_is_skipped
          next_nodeset_is_skipped = false
          next
      end
      if nodeset.to_s.include?("color: #990000;")
        amazon_point = nodeset.inner_text
        amazon_point = amazon_point.strip.gsub(/,/, '').sub(/([0-9]+)pt.*/, '\1')
        amazon_points.push(amazon_point)
        next_nodeset_is_skipped = true # 「ポイント」と「送料」に共通の class="a-color-secondary" ではポイントの方が先に来る
      else
        amazon_points.push("0")
      end
    end
    amazon_points
  end
end

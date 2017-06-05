require 'amazomania/parse_html'

module SalesData
  include ParseHtml

  def sales_data(asin)
    parse_html(asin) #=> @shop_names, @prices, @main_conditions, @sub_conditions, @shipping_prices, @amazon_points
    loop_count = @shop_names.length # not sexy
    sales_data =[]

    loop_count.times do |i|
      sales_data << {
        shop: @shop_names[i],
        price: @prices[i],
        main_condition: @main_conditions[i],
        sub_condition: @sub_conditions[i],
        shipping_price: @shipping_prices[i],
        amazon_point: @amazon_points[i],
      }
    end

    sales_data
  end
end

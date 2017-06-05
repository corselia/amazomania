require 'nokogiri'
require 'amazomania/create_uri'
require 'amazomania/create_session'

module Scraping
  include CreateUri
  include CreateSession

  def scraping(asin)
    uri = all_type_product_uri(asin)
    session = create_session

    session.visit(uri)
    html = session.html
    Nokogiri::HTML.parse(html, nil, "UTF-8")
  end
end

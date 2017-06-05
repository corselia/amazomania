require "amazomania/version"
require "amazomania/sales_data"

module Amazomania
  extend SalesData

  def self.data(asin)
    sales_data(asin)
  end
end

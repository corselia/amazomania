[![CircleCI](https://circleci.com/gh/corselia/amazomania/tree/master.svg?style=svg)](https://circleci.com/gh/corselia/amazomania/tree/master)

# Amazomania
- you can get product sales data of `amazon.co.jp`
- for example, lowest price, shop name, shipping price, condition and etc

## Installation
```bash
$ gem install 'amazomania'
```

## Usage

#### basical format

```ruby
require 'amazomania'

Amazomania.data(ASIN) #=> Array
```

#### example

```ruby
require 'amazomania'

sales_data = Amazomania.data("B01N06V253")
p sales_data
```

#### return value example
```ruby
sales_data = [
  {
    shop: "shop_a",
    price: 100,
    main_condition: "新品",
    sub_condition: "新品",
    shipping_price: 500,
    amazon_point: 0
  },
  {
    shop: "shop_b",
    price: 500,
    main_condition: "新品",
    sub_condition: "新品",
    shipping_price: 350,
    amazon_point: 0
  },
  {
    shop: "shop_c",
    price: 1000,
    main_condition: "中古品",
    sub_condition: "非常に良い",
    shipping_price: 150,
    amazon_point: 0
  }
]
```

## Notes
- too many accesses in short time occurs `Amazon CAPTCHA` and you don't access product page
- in case shipping price is based on living place, it's on Tokyo
- maybe available at `amazon.com`?
- when amazon's html code is changed, this gem will run incorrectly X-(

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/corselia/amazomania](https://github.com/corselia/amazomania). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

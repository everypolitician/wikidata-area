# Wikidata::Area

Fetch information about Constituencies or other Areas from Wikidata, as
a flat hash, suitable for saving to a database (for example in a
morph.io scraper).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wikidata-area'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikidata-area

## Usage

```ruby
data = Wikidata::Areas.new(ids: wanted).data
ScraperWiki.save_sqlite(%i(id), data)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/everypolitician/wikidata-area.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


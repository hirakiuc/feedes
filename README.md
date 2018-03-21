# Feedes

[![CircleCI](https://circleci.com/gh/hirakiuc/feedes/tree/master.svg?style=shield&circle-token=d375d3cf61a645a3fb5e46bd4bebe6c24382b029)](https://circleci.com/gh/hirakiuc/feedes/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/50376b7f8db3311a51a1/maintainability)](https://codeclimate.com/github/hirakiuc/feedes/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/50376b7f8db3311a51a1/test_coverage)](https://codeclimate.com/github/hirakiuc/feedes/test_coverage)

A ruby library to fetch and parse rss feed.

This gem supports RSS1.0(RDF), RSS2.0, Atom.

WARN: This gem contains very simple SAX parsers to parse feeds. So some this gem does not support complex XML.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'feedes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feedes

## Usage

```ruby
require 'feedes'

feed = Feedes.fetch('https://example.com/path/to/page.rss')
feed.each_item do |item|
  p item
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hirakiuc/feedes.


# Feedes

A ruby library to fetch and parse rss feed.

This gem will support RSS1.0, RSS2.0, Atom.

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
feed.items.each do |item|
  p item
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/feedes.


# frozen_string_literal: true

require 'nokogiri'

require_relative './feedes/fetcher.rb'
require_relative './feedes/parser/feed_parser.rb'
require_relative './feedes/version.rb'

require_relative './feedes/model/base_feed.rb'

module Feedes
  class << self
    # Fetch the feed
    #
    # @param [string] url the feed url.
    # @param [Hash] options
    # @option options [Array] :headers Array of request headers.
    # @option options [Array] :content_types Array of acceptable content-type strings.
    def fetch(url, options = {})
      res = Fetcher.new(options).fetch(url)
      parser = Parser::FeedParser.new(options[:type] || :guess)

      parser.parse(res.body)
    end
  end
end

require_relative './feedes/hatena.rb'

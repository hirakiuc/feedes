# frozen_string_literal: true

require 'nokogiri'

require_relative './feedes/fetcher.rb'
require_relative './feedes/parser.rb'
require_relative './feedes/version.rb'

require_relative './feedes/result.rb'

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
      parser = Parser.new(options[:type] || :guess)
      result = parser.parse(res.body)

      Result.new(result.feed_meta, result.items)
    end
  end
end

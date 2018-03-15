# frozen_string_literal: true

require 'nokogiri'

require_relative './feedes/fetcher.rb'
require_relative './feedes/parser.rb'
require_relative './feedes/version.rb'

require_relative './feedes/result.rb'

module Feedes
  class << self
    def fetch(url, options = {})
      res = Fetcher.new.fetch(url, options)
      parser = Parser.new(options[:type] || :guess)
      result = parser.parse(res.body)

      Result.new(result.feed_meta, result.items)
    end
  end
end

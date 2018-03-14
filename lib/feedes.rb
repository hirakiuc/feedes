# frozen_string_literal: true

require 'nokogiri'

require_relative './feedes/fetcher.rb'
require_relative './feedes/parser.rb'
require_relative './feedes/version.rb'

module Feedes
  class << self
    def fetch(url, options = {})
      res = Fetcher.new.fetch(url, options)
      parser = Parser.new(options[:type] || :guess)
      parser.parse(res.body)
    end
  end
end

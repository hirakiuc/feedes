require 'feedes/version'

require 'nokogiri'

require_relative './feedes/document/base.rb'
require_relative './feedes/document/rdf.rb'

require_relative './feedes/document/guess.rb'

module Feedes
  class << self
    def fetch(url, options = {})
      res = Fetcher.new.fetch(url, options)

      type = guess(res)
    end

    def guess(xml)
      doc = Feedes::Document::Guess.new
      parser = ::Nokogiri::XML::SAX::Parser.new(doc)
      parser.parse(xml)

      parser.document
    end
  end
end

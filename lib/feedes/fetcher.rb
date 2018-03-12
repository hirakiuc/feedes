# frozen_string_literal: true

require 'uri'
require 'rest-client'

module Feedes
  class Fetcher
    attr_reader :url
    attr_reader :results

    # Fetch and Parse the feed.
    #
    # @param [String] url the feed url
    # @param [Symbol] type the feed type(:rdf, :rss, :atom)
    # @return [Feedes::Result] fetch and parse result
    def fetch(url, type)
      head = send_request(:head, @uri, headers)
      acceptable_content!(head.headers[:content_type])

      res = send_request(:get)

      doc = get_document(type)

      parser = get_parser(type)
      parser.parse(res)

      Feedes::Result.new(url, type, parser)
    end

    private

    def get_parser(type)
      Nokogiri::XML::SAX::Parser.new(get_document_class(type))
    end

    def get_document_class(type)
      case type
      when :atom  then Feedes::Document::Atom
      when :rss   then Feedes::Document::Rss
      when :rdf   then Feedes::Document::Rdf
      else             throw "UnSupported type: #{type}"
      end
    end
  end
end

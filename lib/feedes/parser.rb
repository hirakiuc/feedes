# frozen_string_literal: true

require_relative './document/base.rb'
require_relative './document/rdf.rb'
require_relative './document/rss.rb'
require_relative './document/atom.rb'
require_relative './document/guess.rb'

require_relative './result.rb'

module Feedes
  class Parser
    def initialize(type)
      @parser = get_parser(type)
    end

    def parse(xml)
      @parser = get_parser(guess_type(xml)) if @parser.nil?
      @parser.parse(xml)

      @parser.document
    end

    private

    def get_parser(type)
      return nil if type == :guess
      Nokogiri::XML::SAX::Parser.new(get_document(type))
    end

    def guess_type(xml)
      parser = Nokogiri::XML::SAX::Parser.new(get_document(:guess))
      parser.parse(xml)

      parser.document.type
    end

    def get_document(type)
      case type
      when :atom  then Feedes::Document::Atom.new
      when :rss   then Feedes::Document::Rss.new
      when :rdf   then Feedes::Document::Rdf.new
      when :guess then Feedes::Document::Guess.new
      else             throw "UnSupported type: #{type}"
      end
    end
  end
end

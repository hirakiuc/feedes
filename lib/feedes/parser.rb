# frozen_string_literal: true

require_relative './document/base.rb'
require_relative './document/rdf.rb'
require_relative './document/rss.rb'
require_relative './document/atom.rb'
require_relative './document/guess.rb'

require_relative './model/atom_feed.rb'
require_relative './model/rdf_feed.rb'
require_relative './model/rss_feed.rb'

module Feedes
  class Parser
    def initialize(type = :guess)
      @type = type
    end

    def parse(xml)
      @type = guess_type(xml) if @type == :guess

      parser = get_parser(guess_type(xml))
      parser.parse(xml)

      wrap_result(parser, @type)
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

    def wrap_result(parser, type)
      doc = parser.document

      cls = get_feed_class(type)

      cls.new(doc.feed_meta, doc.items)
    end

    def get_feed_class(type)
      case type
      when :atom then Feedes::Model::AtomFeed
      when :rdf then Feedes::Model::RdfFeed
      when :rss then Feedes::Model::RssFeed
      else       throw "UnSupported type: #{type}"
      end
    end
  end
end

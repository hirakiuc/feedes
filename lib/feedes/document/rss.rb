# frozen_string_literal: true

require_relative './rss_item.rb'

module Feedes
  module Document
    class Rss < Base
      def begin_element(path, name, attrs = {}); end

      def finish_element(path, name)
        return unless path == '//rss/channel/item'
        return if @result.empty?

        @items.push(RssItem.new(@result))
        @result = {}
      end

      def found_chars(path, name, str)
        if path == "//rss/channel/item/#{name}"
          v = convert_chars(name, str)
          @result[name] = v if v
        elsif path == '//rss/channel/item'
          return
        elsif path == "//rss/channel/#{name}"
          @feed_meta[name.to_sym] = str if str
        end
      end

      private

      def convert_chars(name, str)
        case name
        when :title, :link, :description
          str
        when :pubDate
          Time.rfc822(str)
        end
      end
    end
  end
end

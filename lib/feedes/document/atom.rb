# frozen_string_literal: true

module Feedes
  module Document
    class Atom < Base
      def begin_element(path, name, attrs = {})
        return unless name == :link

        rel = attrs[:rel]
        value = { href: attrs[:href] }
        value[:title] = attrs[:title] if attrs[:title]

        case path
        when '//feed/entry/link'
          @result[:link] = {} unless @result[:link]
          @result[:link][rel.to_sym] = value unless rel.nil?
        when '//feed/link'
          @feed_meta[:link] = {} unless @feed_meta[:link]
          @feed_meta[:link][rel.to_sym] = value unless rel.nil?
        end
      end

      def found_chars(path, name, str)
        if path == "//feed/entry/#{name}"
          v = convert_chars(name, str)
          @result[name] = v if v
        elsif path == '//feed/entry/author/name'
          @result[:author] = str
        elsif name != :entry && path == "//feed/#{name}"
          @feed_meta[name] = str
        end
      end

      def finish_element(path, _name)
        return unless path == '//feed/entry'
        return if @result.empty?

        @items.push(@result)
        @result = {}
      end

      private

      def convert_chars(name, str)
        case name
        when :id, :title, :summary
          str
        when :issued
          Time.strptime(str, '%Y-%m-%dT%H:%M:%S%z')
        end
      end
    end
  end
end

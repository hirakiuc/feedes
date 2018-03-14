# frozen_string_literal: true

module Feedes
  module Document
    class Rss < Base
      def begin_element(path, name, attrs = {}); end

      def finish_element(path, name); end

      def found_chars(path, name, str)
        # if path =~ %r{xml\/channel\/item\/#{name}}
        #   @result[name] = convert_chars(name, str)
        # end
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

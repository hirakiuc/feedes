require 'nokogiri'

module Feedes
  module Document
    class Base < ::Nokogiri::XML::SAX::Document
      def initialize
        @items = []
        @feed_meta = {}

        @result = {}
        @stack = []
        @buffer = ''
      end

      #-------------------------------------------
      # subclass should override this method
      def begin_element(_path, _name, _attrs = {}); end
      def finish_element(_path, _name); end
      def found_chars(_path, _name, _string); end
      #-------------------------------------------

      def start_element(name, attrs = {})
        push_stack(name)
        @buffer = ''
        begin_element(path(), name_with_ns(name), convert_attr_hash(attrs))
      end

      def start_element_namespace(
        name, attrs = [], prefix = nil, _uri = nil, _ns = [])

        push_stack(name, prefix)
        @buffer = ''

        begin_element(
          path(), name_with_ns(name, prefix), convert_attr_hash(attrs)
        )
      end

      def characters(str)
        @buffer += str
      end

      def end_element(name)
        found_chars(path(), name_with_ns(name), @buffer) unless @buffer.empty?

        @buffer = ''

        finish_element(path, name_with_ns(name))
        pop_stack()
      end

      def end_element_namespace(name, prefix = nil, _uri = nil)
        found_chars(path(), name_with_ns(name, prefix), @buffer) unless @buffer.empty?

        @buffer = ''

        finish_element(path(), name_with_ns(name, prefix))
        pop_stack()
      end

      protected

      def push_stack(name, prefix = nil)
        @stack.push(name_with_ns(name, prefix))
      end

      def pop_stack
        @stack.pop
      end

      def name_with_ns(name, prefix = nil)
        prefix ? "#{prefix}:#{name}".to_sym : name.to_sym
      end

      def path
        '//' + @stack.join('/')
      end

      # FIXME: to be refactored!
      def convert_attr_hash(attrs = [])
        h = {}
        attrs.each do |v|
          # v is Nokogiri::XML::SAX::Parser::Attribute
          # see http://nokogiri.org/Nokogiri/XML/SAX/Parser/Attribute.html
          key = v.prefix ? v.prefix + ':' : ''
          key += v.localname

          h[key.to_sym] = v.value
        end
        h
      end
    end
  end
end

# frozen_string_literal: true

module Feedes
  module Model
    class BaseFeed
      attr_reader :meta, :items

      def initialize(meta, items)
        @meta = meta
        @items = items
      end

      def title
        @meta[:title]
      end

      def link
        @meta[:link]
      end

      def description
        @meta[:description]
      end

      def each_item
        return unless block_given?

        @items.each { |item| yield item }
      end
    end
  end
end

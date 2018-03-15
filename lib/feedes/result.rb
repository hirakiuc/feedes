# frozen_string_literal: true

module Feedes
  class Result
    attr_reader :feed, :items

    def initialize(meta, items)
      @feed = meta
      @items = items
    end

    def each_item
      return unless block_given?

      @items.each { |item| yield item }
    end
  end
end

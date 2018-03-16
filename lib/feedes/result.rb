# frozen_string_literal: true

module Feedes
  class Result
    attr_reader :meta, :items

    def initialize(meta, items)
      @meta = meta
      @items = items
    end

    def each_item
      return unless block_given?

      @items.each { |item| yield item }
    end
  end
end

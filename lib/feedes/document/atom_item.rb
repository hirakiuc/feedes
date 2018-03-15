# frozen_string_literal: true

module Feedes
  module Document
    class AtomItem
      attr_reader :title, :description, :date, :url, :attrs

      def initialize(attrs)
        @title = attrs[:title]
        @description = attrs[:summary]
        @date = attrs[:updated]
        @url = attrs[:id]
        @attrs = attrs
      end
    end
  end
end

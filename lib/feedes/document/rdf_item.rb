# frozen_string_literal: true

module Feedes
  module Document
    class RdfItem
      attr_reader :title, :description, :date, :url, :attrs

      def initialize(attrs)
        @title = attrs[:title]
        @description = attrs[:description]
        @date = attrs[:'dc:date']
        @url = attrs[:link]
        @attrs = attrs
      end
    end
  end
end

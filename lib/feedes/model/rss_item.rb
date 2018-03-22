# frozen_string_literal: true

module Feedes
  module Model
    class RssItem
      attr_reader :title, :description, :date, :url, :attrs

      def initialize(attrs)
        @title = attrs[:title]
        @description = attrs[:description]
        @date = attrs[:pubDate]
        @url = attrs[:link]
        @attrs = attrs
      end
    end
  end
end

# frozen_string_literal: true

require_relative './base_feed.rb'

module Feedes
  module Model
    class AtomFeed < BaseFeed
      def link
        @meta[:link][:href]
      end

      def description
        @meta[:subtitle]
      end
    end
  end
end

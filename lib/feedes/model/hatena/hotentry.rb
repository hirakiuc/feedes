# frozen_string_literal: true

module Feedes
  module Model
    module Hatena
      class Hotentry
        attr_reader :title, :description, :date, :url, :attrs
        attr_reader :hatebu_count, :rank, :category

        def initialize(theday, attrs)
          @title = attrs[:title]
          @description = attrs[:desc]
          @date = attrs[:dc_date]
          @url = attrs[:link]

          @hatebu_count = attrs[:hatebu_count]
          @rank = attrs[:rank]
          @category = attrs[:category]
        end
      end
    end
  end
end

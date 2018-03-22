# frozen_string_literal: true

require_relative '../base_feed.rb'

module Feedes
  module Model
    module Hatena
      class HotentryFeed < BaseFeed
        def title
          "Hatebu HotEntry at #{@meta[:theday]}"
        end

        def link
          "http://b.hatena.ne.jp/hotentry/#{theday}?layout=list"
        end

        def description
          nil
        end
      end
    end
  end
end

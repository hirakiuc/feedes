# frozen_string_literal: true

require_relative './fetcher.rb'
require_relative './parser/hatena_hotentry_parser.rb'

module Feedes
  module Hatena
    class << self
      # Fetch HotEntries from Hatena Bookmark at the day
      #
      # @param [String] theday date string in "YYYYMMDD" format.
      # @param [Hash] options
      # @option options [Array] :headers Array of request headers.
      # @option options [Array] :content_types Array of acceptable content-type strings.
      def hotentry(theday, options = {})
        # TODO validate theday format YYYYMMDD
        url = "http://b.hatena.ne.jp/hotentry/#{theday}?layout=list"

        opts = options.merge({
          content_types: ['text/html']
        })
        res = Fetcher.new(opts).fetch(url)

        parser = Parser::HatenaHotentryParser.new(theday)

        parser.parse(res.body)
      end
    end
  end
end

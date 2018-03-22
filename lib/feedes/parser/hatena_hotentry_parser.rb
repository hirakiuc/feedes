# frozen_string_literal: true

require_relative '../model/hatena/hotentry.rb'
require_relative '../model/hatena/hotentry_feed.rb'

module Feedes
  module Parser
    class HatenaHotentryParser
      def initialize(theday)
        @theday = theday
      end

      def parse(html)
        items = parse_html(html)

        Feedes::Model::Hatena::HotentryFeed.new(@theday, items)
      end

      private

      def parse_html(html)
        doc = Nokogiri::HTML(html, nil, 'utf-8')

        doc.css('div.entrylist-contents').map do |entry|
          css_class = entry['class'].split()
          next nil if %w(ad-unit recommended).include?(css_class)

          hash = parse_entry(entry)
          hash.merge(the_day: @theday)
        end.compact.map.with_index(1) do |hash, i|
          hash[:rank] = i
          Feedes::Model::Hatena::Hotentry.new(@theday, hash)
        end
      end

      def parse_entry(entry)
        h = {}

        content_users = entry.css('span.entrylist-contents-users').first
        h[:hatebu_count] = content_users.css('a span').text.to_i

        content_title = entry.css('h3.entrylist-contents-title a').first
        h[:title] = content_title.attributes['title'].value
        h[:link] = content_title.attributes['href'].value

        content_body = entry.css('div.entrylist-contents-body').first
        h[:desc] = content_body.css('p.entrylist-contents-description').text
        h[:desc].gsub!("\n", '') if h[:desc]


        h[:dc_subject] = nil

        issued_at_element = entry.css('li.date').first
        h[:dc_date] = \
          begin
            Time.parse(issued_at_element) if issued_at_element
          rescue
            Time.now.ago(10.hours)
          end

        category_element = entry.css('li.category a.category').first
        content_detail = entry.css('div.entrylist-contents-detail').first

        category_element = content_detail.css('li.entry-list-contents-category a').first
        h[:category] = category_element.text if category_element

        h
      end
    end
  end
end

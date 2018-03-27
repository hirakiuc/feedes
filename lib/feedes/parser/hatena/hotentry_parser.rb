# frozen_string_literal: true

require_relative '../../model/hatena/hotentry.rb'
require_relative '../../model/hatena/hotentry_feed.rb'

module Feedes
  module Parser
    module Hatena
      class HotentryParser
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
          [
            parse_entry_body(entry),
            parse_entry_detail(entry),
            { dc_subject: nil }
          ].reduce({}) { |memo, h| memo.merge(h) }
        end

        def parse_entry_body(element)
          h = {}

          content_users = element.css('span.entrylist-contents-users').first
          h[:hatebu_count] = content_users.css('a span').text.to_i

          content_title = element.css('h3.entrylist-contents-title a').first
          h[:title] = content_title.attributes['title'].value
          h[:link] = content_title.attributes['href'].value

          content_body = element.css('div.entrylist-contents-body').first
          h[:desc] = content_body.css('p.entrylist-contents-description').text
          h[:desc].delete!("\n") if h[:desc]

          h
        end

        def parse_entry_detail(element)
          h = {}

          content_meta = element.css(
            'div.entrylist-contents-detail ul.entrylist-contents-meta'
          ).first

          # category
          category_element = content_meta.css('li.entrylist-contents-category a').first
          h[:category] = category_element.text if category_element

          issued_at_element = content_meta.css('li.entrylist-contents-date').first
          h[:dc_date] = \
            begin
              Time.parse(issued_at_element.text) if issued_at_element
            rescue => e
              pp e
              Time.now
            end

          h
        end
      end
    end
  end
end

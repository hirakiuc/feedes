require 'spec_helper'

RSpec.describe Feedes::Model::RssItem do
  describe 'new' do
    it 'should create new instance' do
      attrs = {
        title: 'Sample Title',
        description: 'Feed description',
        pubDate: Time.now,
        link: 'http://example.com/feed.rss'
      }

      m = Feedes::Model::RssItem.new(attrs)
      expect(m).to be_an_instance_of(Feedes::Model::RssItem)
      expect(m.title).to eq(attrs[:title])
      expect(m.description).to eq(attrs[:description])
      expect(m.date).to eq(attrs[:pubDate])
      expect(m.url).to eq(attrs[:link])
      expect(m.attrs).to eq(attrs)
    end
  end
end

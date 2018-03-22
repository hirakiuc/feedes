require 'spec_helper'

RSpec.describe Feedes::Model::RdfFeed do
  describe 'new' do
    it 'should create new instance' do
      meta = {
        title: 'Sample Rdf Feed',
        link: 'http://example.com/path/to/feed.rdf',
        description: 'some description'
      }
      items = []
      m = Feedes::Model::RdfFeed.new(meta, items)

      expect(m).to inherit_from(::Feedes::Model::BaseFeed)

      expect(m.title).to eq(meta[:title])
      expect(m.link).to eq(meta[:link])
      expect(m.description).to eq(meta[:description])

      expect(m.items).to eq(items)
    end
  end
end

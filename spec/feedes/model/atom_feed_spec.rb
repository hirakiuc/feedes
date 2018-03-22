require 'spec_helper'

RSpec.describe Feedes::Model::AtomFeed do
  describe 'new' do
    it 'should create new instance' do
      meta = {
        title: 'Sample Atom Feed',
        link: {
          href: 'http://example.com/path/to/feed.atom'
        },
        subtitle: 'some description'
      }
      items = []
      m = Feedes::Model::AtomFeed.new(meta, items)

      expect(m).to inherit_from(::Feedes::Model::BaseFeed)

      expect(m.title).to eq(meta[:title])
      expect(m.link).to eq(meta[:link][:href])
      expect(m.description).to eq(meta[:subtitle])

      expect(m.items).to eq(items)
    end
  end
end

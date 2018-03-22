require 'spec_helper'

RSpec.describe Feedes::Model::AtomItem do
  describe 'new' do
    it 'should create new instance' do
      attrs = {
        title: 'Sample Title',
        summary: 'Feed description',
        updated: Time.now,
        id: 'http://example.com/feed.atom'
      }

      m = Feedes::Model::AtomItem.new(attrs)
      expect(m).to be_an_instance_of(Feedes::Model::AtomItem)
      expect(m.title).to eq(attrs[:title])
      expect(m.description).to eq(attrs[:summary])
      expect(m.date).to eq(attrs[:updated])
      expect(m.url).to eq(attrs[:id])
      expect(m.attrs).to eq(attrs)
    end
  end
end

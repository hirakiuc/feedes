require 'spec_helper'

RSpec.describe Feedes::Model::RdfItem do
  describe 'new' do
    it 'should create new instance' do
      attrs = {
        title: 'Sample Title',
        description: 'Feed description',
        'dc:date': Time.now,
        link: 'http://example.com/feed.rdf',
      }

      m = Feedes::Model::RdfItem.new(attrs)
      expect(m).to be_an_instance_of(Feedes::Model::RdfItem)
      expect(m.title).to eq(attrs[:title])
      expect(m.description).to eq(attrs[:description])
      expect(m.date).to eq(attrs[:'dc:date'])
      expect(m.url).to eq(attrs[:link])
      expect(m.attrs).to eq(attrs)
    end
  end
end

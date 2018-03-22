require 'spec_helper'

RSpec.describe Feedes::Model::BaseFeed do
  describe 'new' do
    it 'should create new instance' do
      meta = {title: 'Sample RDF Feed'}
      items = [1,2,3]

      m = Feedes::Model::BaseFeed.new(meta, items)
      expect(m).to be_an_instance_of(Feedes::Model::BaseFeed)
      expect(m.meta).to be_eql(meta)
      expect(m.items).to be_eql(items)
    end
  end

  describe '#title' do
    it 'should return title attribute of meta' do
      meta = {
        title: 'Sample Feed'
      }
      items =[]
      m = Feedes::Model::BaseFeed.new(meta, items)

      expect(m.title).to eq(meta[:title])
    end
  end

  describe '#link' do
    it 'should return link attribute of meta' do
      meta = {
        link: 'http://example.com/path/to/feed.rss'
      }
      items = []
      m = Feedes::Model::BaseFeed.new(meta, items)

      expect(m.link).to eq(meta[:link])
    end
  end

  describe 'description' do
    it 'should return description attribute of meta' do
      meta = {
        description: 'some description'
      }
      items = []
      m = Feedes::Model::BaseFeed.new(meta, items)

      expect(m.description).to eq(meta[:description])
    end
  end

  describe 'each_item' do
    it 'should iterate each items' do
      meta = {}
      items = [1,2,3]

      m = Feedes::Model::BaseFeed.new(meta, items)
      expect { |b| m.each_item(&b) }.to yield_successive_args(1,2,3)
    end
  end
end

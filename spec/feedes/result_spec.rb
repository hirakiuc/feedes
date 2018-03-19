require 'spec_helper'

RSpec.describe Feedes::Result do
  describe 'new' do
    it 'should create new instance' do
      meta = {title: 'Sample RDF Feed'}
      items = [1,2,3]

      m = Feedes::Result.new(meta, items)
      expect(m).to be_an_instance_of(Feedes::Result)
      expect(m.meta).to be_eql(meta)
      expect(m.items).to be_eql(items)
    end
  end

  describe 'each_item' do
    it 'should iterate each items' do
      meta = {}
      items = [1,2,3]

      m = Feedes::Result.new(meta, items)
      expect { |b| m.each_item(&b) }.to yield_successive_args(1,2,3)
    end
  end
end

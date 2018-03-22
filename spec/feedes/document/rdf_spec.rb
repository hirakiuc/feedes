require 'spec_helper'

RSpec.describe Feedes::Document::Rdf do
  let(:parser) do
    Nokogiri::XML::SAX::Parser.new(
      Feedes::Document::Rdf.new
    )
  end

  describe 'parse RDF document' do
    it 'should parse the document' do
      xml = feed_xml('feed.rdf')

      expect { parser.parse(xml) }.not_to raise_error
      doc = parser.document

      expect(doc.feed_meta[:title]).to eq('gihyo.jp：総合')
      expect(doc.feed_meta[:link]).to eq('http://gihyo.jp/')

      expect(doc.items.size).to eq(20)
      doc.items.each do |item|
        expect(item).to be_an_instance_of(Feedes::Model::RdfItem)
        expect(item.title).not_to be_nil
        expect(item.description).not_to be_nil
        expect(item.date).not_to be_nil
        expect(item.url).not_to be_nil

        expect(item.attrs).not_to be_empty
      end
    end
  end
end

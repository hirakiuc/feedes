require 'spec_helper'

RSpec.describe Feedes::Document::Guess do
  let(:parser) do
    Nokogiri::XML::SAX::Parser.new(
      Feedes::Document::Guess.new
    )
  end

  describe 'parse and guess document type' do
    let(:doc) do
      xml = feed_xml(feed_name)
      parser.parse(xml)
      parser.document
    end

    context 'when the document is rdf' do
      let(:feed_name) { 'feed.rdf' }

      it 'should guess the document type' do
        expect(doc.type).to eq(:rdf)
      end
    end

    context 'when the document is rss' do
      let(:feed_name) { 'feed.rss' }

      it 'should guess the document type' do
        expect(doc.type).to eq(:rss)
      end
    end

    context 'when the document is atom' do
      let(:feed_name) { 'feed.atom' }

      it 'should guess the document type' do
        expect(doc.type).to eq(:atom)
      end
    end

    context 'when the document is not feed xml' do
      let(:feed_name) { 'feed.xml' }

      it 'should guess the document type' do
        expect(doc.type).to eq(:unknown)
      end
    end
  end
end

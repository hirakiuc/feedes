require 'spec_helper'

RSpec.describe Feedes::Parser::FeedParser do
  describe 'initialize' do
    context 'without argument' do
      it 'should create new instance' do
        m = Feedes::Parser::FeedParser.new
        expect(m).to be_an_instance_of(Feedes::Parser::FeedParser)
        expect(m.instance_variable_get(:@type)).to eq(:guess)
      end
    end

    context 'with type' do
      it 'should create new instance' do
        m = Feedes::Parser::FeedParser.new(:rss)
        expect(m).to be_an_instance_of(Feedes::Parser::FeedParser)
        expect(m.instance_variable_get(:@type)).to eq(:rss)
      end
    end
  end

  describe '#parse' do
    let(:parser) { Feedes::Parser::FeedParser.new(type) }
    let(:xml) { feed_xml(fname) }

    context 'when type is :guess' do
      let(:fname) { 'feed.rss' }

      it 'should guess and parse the xml' do
        feed_parser = Feedes::Parser::FeedParser.new
        result = feed_parser.parse(xml)

        expect(result).to be_an_instance_of(Feedes::Model::RssFeed)
      end
    end

    context 'when type is :rdf' do
      let(:type) { :rdf }
      let(:fname) { 'feed.rdf' }

      it 'should parse RDF' do
        result = parser.parse(xml)
        expect(result).to be_an_instance_of(Feedes::Model::RdfFeed)
      end
    end

    context 'when type is :rss' do
      let(:type) { :rss }
      let(:fname) { 'feed.rss' }

      it 'should parse RSS' do
        result = parser.parse(xml)
        expect(result).to be_an_instance_of(Feedes::Model::RssFeed)
      end
    end

    context 'when type is :atom' do
      let(:type) { :atom }
      let(:fname) { 'feed.atom' }

      it 'should parse AROM' do
        result = parser.parse(xml)
        expect(result).to be_an_instance_of(Feedes::Model::AtomFeed)
      end
    end

    context 'when type is :invalid' do
      let(:type) { :invalid }
      let(:fname) { 'feed.rdf' }

      it 'should throw error' do
        expect { parser.parse(xml) }.to raise_error(/UnSupported type/)
      end
    end
  end
end

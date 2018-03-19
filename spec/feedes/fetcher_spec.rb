require 'spec_helper'

RSpec.describe Feedes::Fetcher do
  before do
    WebMock.enable!
    stub_request(:get,  /example.com/).to_rack(FakeServer)
    stub_request(:head, /example.com/).to_rack(FakeServer)
  end
  after { WebMock.disable! }

  def fetcher
    Feedes::Fetcher.new
  end

  describe '#fetch' do
    context 'when the content does not found' do
      it 'should throw error' do
        expect { fetcher.fetch('http://example.com/error/not_found') }.to raise_error
      end
    end

    context 'when the content is not acceptable content-type' do
      it 'should throw error' do
        expect  { fetcher.fetch("http://example.com/feed.rdf?type=#{CGI.escape('text/html')}") }.to raise_error
      end
    end

    context 'when the content is a rdf feed' do
      it 'should fetch the rdf feed' do
        body = fetcher.fetch('http://example.com/feed.rdf')
        expect(body).not_to be_empty
      end
    end

    context 'when the content is a rss feed' do
      it 'should fetch the rss feed' do
        body = fetcher.fetch('http://example.com/feed.rss')
        expect(body).not_to be_empty
      end
    end

    context 'when the content is a arom feed' do
      it 'should fetch the atom feed' do
        body = fetcher.fetch('http://example.com/feed.atom')
        expect(body).not_to be_empty
      end
    end
  end
end

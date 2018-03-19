require 'sinatra/base'

class FakeServer < Sinatra::Base
  [
    {name: 'feed.rdf', type: 'application/xhtml+xml'},
    {name: 'feed.rss', type: 'application/rss+xml'},
    {name: 'feed.atom', type: 'application/atom+xml'}
  ].each do |v|
    get "/#{v[:name]}" do
      content_type (params['type'] || v[:type])
      status 200

      file_path = Pathname.new(__dir__).join('contents', v[:name])
      send_file file_path
    end

    head "/#{v[:name]}" do
      content_type (params['type'] || v[:type])
      status 200
    end
  end
end

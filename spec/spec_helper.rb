require "bundler/setup"
require 'webmock/rspec'

require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_filter '.bundle/'
end

require "feedes"
require 'cgi'

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

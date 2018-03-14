# frozen_string_literal: true

require 'uri'
require 'rest-client'

module Feedes
  class Fetcher
    attr_reader :url
    attr_reader :results

    def initialize
      @accept_types = %w(
        application/xhtml+xml
        application/atom+xml
        application/x.atom+xml
        application/rss+xml
        application/xml
      )
    end

    # Fetch and Parse the feed.
    #
    # @param [String] url the feed url
    # @return [String] fetched result.
    def fetch(url)
      uri = URI.parse(url)

      head = send_request(:head, uri, {})
      acceptable_content!(head.headers[:content_type])

      send_request(:get, uri, {})
    end

    private

    def acceptable_content!(content_type)
      return if acceptable_content?(content_type)

      raise "Can't accpet content-type: #{content_type}"
    end

    def acceptable_content?(content_type)
      type = content_type

      pattern_types = @accept_types.select { |v| v.instance_of?(Regexp) }
      return true unless pattern_types.select { |v| type =~ v }.any?

      fixed_types = @accept_types.select { |v| v.instance_of?(String) }
      fixed_types.include?(type)
    end

    def request_options(method, uri, headers)
      {
        method: method,
        url: uri.to_s,
        headers: headers,
        max_redirects: 10,
        verify_ssl: OpenSSL::SSL::VERIFY_NONE,
        timeout: 30
      }
    end

    def send_request(method, uri, headers)
      options = request_options(method, uri, headers)
      @response = RestClient::Request.execute(options)

      content_type = @response.headers[:content_type]
      raise "Got http status code(#{@response.code}) by #{method} request from #{uri}" \
        unless @response.code == 200
      acceptable_content!(content_type)

      @response
    rescue => e
      raise e
    end
  end
end

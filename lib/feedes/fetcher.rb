# frozen_string_literal: true

require 'uri'
require 'rest-client'

module Feedes
  class Fetcher
    attr_reader :url
    attr_reader :results

    # Constructor
    #
    # @param [Hash] options
    # @option options [Array] :content_types Array of acceptable content-type strings.
    def initialize(options = {})
      @accept_types = %w(
        application/xhtml+xml
        application/atom+xml
        application/x.atom+xml
        application/rss+xml
        application/xml
      ).concat(options[:content_types] || []).uniq
    end

    # Fetch and Parse the feed.
    #
    # @param [String] url the feed url
    # @param [Hash] options
    # @option options [Array] :headers Array of request header strings
    # @return [String] fetched result.
    def fetch(url, options = {})
      uri = URI.parse(url)

      headers = request_headers(options)

      head = send_request(:head, uri, headers)
      acceptable_content!(head.headers[:content_type])

      send_request(:get, uri, headers)
    end

    private

    def request_headers(options)
      { 'User-Agent' => 'A ruby app with feedes' }.merge(options[:headers] || {})
    end

    def acceptable_content!(content_type)
      return if acceptable_content?(content_type)

      raise "Can't accpet content-type: #{content_type}"
    end

    def acceptable_content?(content_type)
      keys = content_type.split(';').map(&:strip)
      keys.any? { |v| @accept_types.include?(v) }
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

      @response
    rescue => e
      raise e
    end
  end
end

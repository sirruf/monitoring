# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'net/https'

module Tools
  #
  # Simple HTTP Request Class
  #
  class HTTPRequest
    def initialize(url)
      raise 'Incorrect URL' unless url_correct?(url)
      @url = URI.parse(url)
    end

    def check
      request = Net::HTTP::Get.new(@url.request_uri,
                                   'User-Agent' => user_agent)
      response = http.request(request)
      { code: response.code.to_i, message: response.message }
    rescue StandardError => e
      { code: 999, message: e.message }
    end

    def self.check(url)
      new(url).check
    end

    private

    def url_correct?(url)
      url_regexp = URI::DEFAULT_PARSER.make_regexp
      url =~ url_regexp
    end

    def user_agent
      'Monitoring Tool'
    end

    def http
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true if @url.scheme == 'https'
      http.read_timeout = 10
      http
    end
  end
end

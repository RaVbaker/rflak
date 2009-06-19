require 'rubygems'
require 'httparty'
require 'user'

module Rflak
  # Usage class to fetch entries from flaker.pl traker service
  class Traker
    include HTTParty

    FLAK_API_URL = 'http://api.flaker.pl/api/type:traker'

    attr_reader :perform_url

    def initialize
      @perform_url = FLAK_API_URL
    end
    

    def self.fetch
      traker = Traker.new
      yield(traker) if block_given?
      parse_response get(traker.perform_url)
    end


    def url(url)
      @perform_url += "/url:#{ url }"
    end


    def format(format)
      @perform_url += "/format:#{ format }"
    end


    def avatars(size)
      @perform_url += "/avatars:#{ size }"
    end


    def limit(value)
      @perform_url += "/limit:#{ value }"
    end


    protected


    def self.parse_response(response)
      response['users'].map do |user_hash|
        User.new(user_hash)
      end
    end
  end
end

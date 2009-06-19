require 'rubygems'
require 'httparty'
require 'entry'

module Rflak
  # Usage class for fetching 'flak's from service. 
  class Connection
    include HTTParty

    FLAK_API_URL = 'http://api.flaker.pl/api'

    def self.go(type)
      flak = Connection.new
      perform_url = FLAK_API_URL + "/type:#{ type }"
      perform_url += yield(flak) if block_given?
      parse_response get(perform_url)
    end


    def self.parse_response(response)
      response['entries'].map do |entry|
        Entry.new(entry)
      end
    end


    # TODO: rewrite definitions
    def login(value)
      "/login:#{ value }"
    end


    def url(value)
      "/url:#{ value }"
    end


    def entry_id(value)
      "/entry_id:#{ value }"
    end


    def source(value)
      "/source:#{ value }"
    end


    def tag(value)
      "/tag:#{ value }"
    end


    def mode(value)
      "/mode:#{ value }"
    end


    def avatars(value)
      "/avatars:#{ value }"
    end


    def limit(value)
      "/limit:#{ value }"
    end


    def from(value)
      "/from:#{ value }"
    end


    def start(value)
      "/start:#{ value }"
    end


    def since(value)
      "/since:#{ value }"
    end


    def sort(value)
      "/sort:#{ value }"
    end


    def comments(value)
      "/comments:#{ value }"
    end
  end
end
require 'rubygems'
require 'httparty'

module Rflak
  class Connection
    include HTTParty

    FLAK_API_URL = 'http://api.flaker.pl/api'

    def self.go(type)
      flak = Connection.new
      perform_url = FLAK_API_URL + "/type:#{ type }"
      perform_url += yield(flak) if block_given?
      puts perform_url
      get(perform_url)
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

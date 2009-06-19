require 'rubygems'
require 'httparty'
require 'entry'

module Rflak
  # Usage class for fetching 'flak's from service. 
  class Connection
    include HTTParty

    FLAK_API_URL = 'http://api.flaker.pl/api'

    attr_reader :perform_url

    def initialize(type)
      @perform_url = FLAK_API_URL + "/type:#{ type }"
    end

    
    def self.go(type)
      flak = Connection.new(type)
      yield(flak) if block_given?
      parse_response get(flak.perform_url)
    end


    def self.parse_response(response)
      response['entries'].map do |entry|
        Entry.new(entry)
      end
    end


    def login(value)
      @perform_url += "/login:#{ value }"
    end


    def url(value)
      @perform_url += "/url:#{ value }"
    end


    def entry_id(value)
      @perform_url += "/entry_id:#{ value }"
    end


    def source(value)
      @perform_url += "/source:#{ value }"
    end


    def tag(value)
      @perform_url += "/tag:#{ value }"
    end


    def mode(value)
      @perform_url += "/mode:#{ value }"
    end


    def avatars(value)
      @perform_url += "/avatars:#{ value }"
    end


    def limit(value)
      @perform_url += "/limit:#{ value }"
    end


    def from(value)
      @perform_url += "/from:#{ value }"
    end


    def start(value)
      @perform_url += "/start:#{ value }"
    end


    def since(value)
      @perform_url += "/since:#{ value }"
    end


    def sort(value)
      @perform_url += "/sort:#{ value }"
    end


    def comments(value)
      @perform_url += "/comments:#{ value }"
    end
  end
end
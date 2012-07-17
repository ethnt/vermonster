require 'faraday'
require 'faraday_middleware'
require 'oauth'

require 'vermonster/authentication'
require 'vermonster/lists'
require 'vermonster/tasks'
require 'vermonster/users'

module Vermonster
  class Client
    attr_accessor :client

    def initialize(options={})
      @client = options

      self.connect!
    end

    def connect!(token = nil)
      @connection = Faraday.new(:url => "https://api.cheddarapp.com/v1") do |f|
        f.adapter Faraday.default_adapter
        f.headers["Authorization"] = "Bearer #{token}" if !token.nil?
        f.request :json
        f.response :json, :content_type => /\bjson$/
      end

      self
    end

    def connection
      @connection
    end

    include Authentication
    include Lists
    include Tasks
    include Users
  end
end

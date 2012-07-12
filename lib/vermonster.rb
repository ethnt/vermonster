require 'faraday'
require 'faraday_middleware'
require 'oauth'

require 'vermonster/authentication'
require 'vermonster/lists'
require 'vermonster/tasks'
require 'vermonster/users'

module Vermonster
  class Client
    attr_accessor :id, :secret, :token

    def initialize(options={})
      @client = {
        :id => options[:id],
        :secret => options[:secret]
      }

      self.create_connection
    end

    def create_connection(token = nil)
      @connection = Faraday.new(:url => "https://api.cheddarapp.com/v1") do |f|
        f.request :json
        f.headers["Authorization"] = "Bearer #{token}" if !token.nil?
        f.response :json, :content_type => /\bjson$/
        f.adapter Faraday.default_adapter
      end
    end

    include Authentication
    include Lists
    include Tasks
    include Users
  end
end

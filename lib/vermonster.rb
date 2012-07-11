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
        "id" => options[:id],
        "secret" => options[:secret]
      }

      @connection = Faraday.new(:url => "http://api.cheddarapp.com/v1") do |f|
        conn.response :json, :content_type => /\bjson$/
        
        conn.adapter Faraday.default_adapter
      end
    end

    include Authentication
    include Lists
    include Tasks
    include Users
  end
end

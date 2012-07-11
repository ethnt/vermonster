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
      @keys = {
        "id" => options[:id],
        "secret" => options[:secret]
      }
    end

    include Authentication
    include Lists
    include Tasks
    include Users
  end
end

module Vermonster
  class Client
    def initialize(options={})
      @client = {
        "id" => options[:client_id],
        "secret" => options[:client_secret]
      }

      @connection = Faraday.new(:url => "http://api.cheddarapp.com/v1") do |f|
        f.adapter Faraday.default_adapter
      end
    end
  end
end
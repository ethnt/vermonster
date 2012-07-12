module Vermonster
  module Authentication

    # Returns the URL for authorizing the user.
    def authorize!
      "http://api.cheddarapp.com/oauth/authorize?client_id=#{@client[:id]}"
    end

    # Get the token for the user.
    def token!(code)
      @connection.basic_auth(@client[:id], @client[:secret])

      response = @connection.post "/oauth/token", { :grant_type => "authorization_code", :code => code }

      @client = @client.merge(:token => response.body["access_token"])

      self.create_connection(@client[:token])
    end

    # Check if authorized or not.
    def authorized?
      if @client[:token]
        true
      else
        false
      end
    end
  end
end
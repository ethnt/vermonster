module Vermonster
  module Authentication

    # Returns the URL for authorizing the user.
    def authorize!(options={})
      url = "https://api.cheddarapp.com/oauth/authorize?client_id=#{@client[:id]}"

      options.each do |key, value|
        url = url << "&#{key}=#{value}"
      end

      url
    end

    # Get the token for the user.
    def token!(code)
      @connection.basic_auth(@client[:id], @client[:secret])

      response = @connection.post "/oauth/token", { :grant_type => "authorization_code", :code => code }

      @client = @client.merge(:token => response.body["access_token"])

      self.connect!(@client[:token])
    end

    # Check if authorized or not.
    def authorized?
      if @connection.get("/me").status != 401
        true
      else
        false
      end
    end
  end
end
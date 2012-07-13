require_relative '../lib/vermonster'

describe Vermonster do
  before :each do
    @secret_keys = {
      :client_id => 'ID', # Get from https://cheddarapp.com/developer
      :client_secret => 'SECRET', # Get from https://cheddarapp.com/developer
      :code => 'CODE' # Get from following the authorize! URL (expires after single-use)
    }
    # Initialize
    @cheddar = Vermonster::Client.new(:id  => @secret_keys[:client_id], :secret  => @secret_keys[:client_secret])
  end

  describe '#authorize!' do
    it 'takes zero parameters and returns a URL string' do
      @cheddar.authorize!.should eql "https://api.cheddarapp.com/oauth/authorize?client_id=#{@cheddar.client[:id]}"
    end
  end

  describe '#token!' do
    it 'takes one parameter and adds token to @client' do
      @cheddar.token!(@secret_keys[:code])
      @cheddar.client[:token].should_not eql nil
    end
  end

  describe '#authorized?' do
    it 'takes no parameters and returns true or false' do
      @cheddar.authorized?.should eql false
      @cheddar.token!(@secret_keys[:code])
      @cheddar.authorized?.should eql true
    end
  end
end
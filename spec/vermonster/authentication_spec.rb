require "spec_helper"

describe Vermonster::Authentication do
  before do
    VCR.insert_cassette 'authentication', :record => :all
  end

  before(:each) do
    @client = {
      :id => "f8d4f247547ad5315dd7127c7799a737",
      :secret => "e8ae0a776a78772412b66635f718776b"
    }

    @cheddar = Vermonster::Client.new(:id => @client[:id], :secret => @client[:secret])
  end

  describe "#authorize_url" do
    it "should return the correct url" do
      @cheddar.authorize_url.should == "https://api.cheddarapp.com/oauth/authorize?client_id=#{@client[:id]}"
    end

    it "should take other parameters" do
      @cheddar.authorize_url(:redirect_uri => "http://google.com", :state => "foobar").should == "https://api.cheddarapp.com/oauth/authorize?client_id=#{@client[:id]}&redirect_uri=http://google.com&state=foobar"
    end
  end

  describe "#token!" do
  end

  describe "#use_token!" do
    it "should authenticate and return true when given an access token" do
      @cheddar.use_token!("6e8c9e570805e75d683a963b1290116a").should be_true
    end

    it "should not authentication and return false when not given a real access token" do
      @cheddar.use_token!("foobar").should be_false
    end
  end

  describe "#authorized?" do
    it "should return true if authorized" do
      @cheddar.use_token!("6e8c9e570805e75d683a963b1290116a")
      @cheddar.authorized?.should be_true
    end

    it "should return false if not authorized" do
      @cheddar.authorized?.should be_false
    end
  end

  after do
    VCR.eject_cassette
  end
end
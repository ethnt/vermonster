require "spec_helper"

describe Vermonster::Authentication do
  before do
    VCR.insert_cassette 'authentication', :record => :new_episodes
  end

  before(:each) do
    @client = {
      :id => "1ec9705a6ad9914570acef93ea44d363",
      :secret => "4b19adb5c7e034c081912c8a49b3a43b"
    }

    @cheddar = Vermonster::Client.new(:id => @client[:id], :secret => @client[:secret])
  end

  describe "#authorize!" do
    it "should return the correct url" do
      @cheddar.authorize!.should == "https://api.cheddarapp.com/oauth/authorize?client_id=#{@client[:id]}"
    end

    it "should take other parameters" do
      @cheddar.authorize!(:redirect_uri => "http://google.com", :state => "foobar").should == "https://api.cheddarapp.com/oauth/authorize?client_id=#{@client[:id]}&redirect_uri=http://google.com&state=foobar"
    end
  end

  describe "#token!" do
  end

  describe "#authorized?" do
  end

  after do
    VCR.eject_cassette
  end
end
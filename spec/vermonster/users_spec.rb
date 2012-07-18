require "spec_helper"

describe Vermonster::Users do
  before do
    VCR.insert_cassette 'users', :record => :all
  end

  before(:each) do
    @client = {
      :id => "f8d4f247547ad5315dd7127c7799a737",
      :secret => "e8ae0a776a78772412b66635f718776b"
    }

    @cheddar = Vermonster::Client.new(:id => @client[:id], :secret => @client[:secret])
    @cheddar.use_token!("6e8c9e570805e75d683a963b1290116a")
  end

  describe "#me" do
    before do
      @moi = @cheddar.me
    end

    it "should be an instance of Vermonster::Users::User" do
      @moi.should be_an_instance_of Vermonster::Users::User
    end

    it "should return the correct information" do
      @moi["username"].should == "vermonster"
      @moi["has_plus"].should be_false
    end
  end

  describe "#users" do
    describe "#me" do
      before do
        @moi = @cheddar.users.me
      end

      it "should be an instance of Vermonster::Users::User" do
        @moi.should be_an_instance_of Vermonster::Users::User
      end

      it "should return the correct information" do
        @moi["username"].should == "vermonster"
        @moi["has_plus"].should be_false
      end
    end
  end

  after do
    VCR.eject_cassette
  end
end
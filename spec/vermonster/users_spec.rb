require "spec_helper"

describe Vermonster::Users do
  before do
    VCR.insert_cassette 'users', :record => :all
  end

  before(:each) do
    oauth!
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
require "spec_helper"

describe Vermonster::Lists do
  before do
    VCR.insert_cassette 'lists', :record => :all
  end

  before(:each) do
    @client = {
      :id => "f8d4f247547ad5315dd7127c7799a737",
      :secret => "e8ae0a776a78772412b66635f718776b"
    }

    @cheddar = Vermonster::Client.new(:id => @client[:id], :secret => @client[:secret])
    @cheddar.use_token!("6e8c9e570805e75d683a963b1290116a")
  end

  describe "#lists.all" do
    before do
      @lists = @cheddar.lists.all
    end

    it "should be an instance of Array" do
      @lists.should be_an_instance_of Array
    end

    it "should return Array of List instances" do
      @lists.first.should be_an_instance_of Vermonster::Lists::List
    end

    it "should return the correct information" do
      @lists.first["title"].should == "Learn Cheddar"
      @lists.first["user"]["username"].should == "vermonster"
    end
  end

  describe "#lists.find(id)" do
    before do
      @list = @cheddar.lists.find(24200)
    end

    it "should be an instance of List" do
      @list.should be_an_instance_of Vermonster::Lists::List
    end

    it "should return the correct information" do
      @list["title"].should == "Learn Cheddar"
      @list["user"]["username"].should == "vermonster"
    end
  end

  describe "List#tasks" do
    before do
      @tasks = @cheddar.lists.find(24200).tasks
    end

    it "should be an instance of Array" do
      @tasks.should be_an_instance_of Array
    end

    it "should return Array of Task instances" do
      @tasks.first.should be_an_instance_of Vermonster::Tasks::Task
    end

    it "should return the correct information" do
      @tasks.first["display_text"] == "Welcome to Cheddar! Click the checkbox to complete tasks"
      @tasks.first["id"] == 182736
    end
  end

  after do
    VCR.eject_cassette
  end
end
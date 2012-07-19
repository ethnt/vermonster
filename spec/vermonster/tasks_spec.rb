require "spec_helper"

describe Vermonster::Tasks do
  before do
    VCR.insert_cassette 'tasks', :record => :all
  end

  before(:each) do
    @client = {
      :id => "f8d4f247547ad5315dd7127c7799a737",
      :secret => "e8ae0a776a78772412b66635f718776b"
    }

    @cheddar = Vermonster::Client.new(:id => @client[:id], :secret => @client[:secret])
    @cheddar.use_token!("6e8c9e570805e75d683a963b1290116a")
  end

  describe "#tasks.from_list(id)" do
    before do
      @tasks = @cheddar.tasks.from_list(24200)
    end

    it "should be an intance of Array" do
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

  describe "#tasks.find(id)" do
    before do
      @task = @cheddar.tasks.find(182736)
    end

    it "should be an instance of Task" do
      @task.should be_an_instance_of Vermonster::Tasks::Task
    end

    it "should return the correct information" do
      @task["display_text"] == "Welcome to Cheddar! Click the checkbox to complete tasks"
      @task["id"] == 182736
    end
  end

  after do
    VCR.eject_cassette
  end
end
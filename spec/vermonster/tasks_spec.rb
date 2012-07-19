require "spec_helper"

describe Vermonster::Tasks do
  before do
    VCR.insert_cassette 'tasks', :record => :all
  end

  before(:each) do
    oauth!
  end

  describe "#tasks" do
    describe "#find(id)" do
      before do
        @task = @cheddar.tasks.find(182736)
      end

      it "should be an instance of Task" do
        @task.should be_an_instance_of Vermonster::Tasks::Task
      end

      it "should return the correct information" do
        @task["display_text"].should == "Welcome to Cheddar! Click the checkbox to complete tasks"
        @task["id"].should == 182736
      end
    end

    describe "#from_list(id)" do
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
        @tasks.first["display_text"].should == "Welcome to Cheddar! Click the checkbox to complete tasks"
        @tasks.first["id"].should == 182736
      end
    end
  end

  after do
    VCR.eject_cassette
  end
end
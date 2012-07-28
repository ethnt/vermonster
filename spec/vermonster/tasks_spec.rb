require "spec_helper"

describe Vermonster::Tasks do
  before do
    VCR.insert_cassette 'tasks', :record => :new_episodes
  end

  before(:each) do
    oauth!
  end

  describe "#tasks" do
    describe "#find" do
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

    describe "#from_list" do
      before do
        @tasks = @cheddar.tasks.from_list(24200)
      end

      it "should be an instance of Array" do
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

    describe "#create" do
      before do
        @task = @cheddar.tasks.create(24200, :text => "Foo to the bar.")
      end

      it "should be an instance of Task" do
        @task.should be_an_instance_of Vermonster::Tasks::Task
      end

      it "should return the correct information" do
        @task["text"].should == "Foo to the bar."
      end
    end

    describe "#archive" do
      before do
        @cheddar.tasks.archive(24393)
      end

      it "should archive all completed tasks" do
        @cheddar.lists.find(24393).tasks.should be_empty
      end
    end

    describe "#archive!" do
      before do
        @cheddar.tasks.archive!(24393)
      end

      it "should archive all tasks" do
        @cheddar.lists.find(24393).tasks.should be_empty
      end
    end
  end

  describe "::Task" do
    describe "#initialize" do
      before do
        @task = @cheddar.tasks.find(182736)
      end

      it "should return the same information from generated instance variables as key-value request" do
        @task["display_text"].should == @task.display_text
      end
    end

    describe "#update" do
      before do
        @task = @cheddar.tasks.find(182737)
        @task.update(:text => "Welcome to Vermonster!")
      end

      it "should return the correct information" do
        @task["text"].should == "Welcome to Vermonster!"
      end
    end
  end

  after do
    VCR.eject_cassette
  end
end
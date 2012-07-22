module Vermonster
  module Tasks
    def tasks
      self.class::Task
    end

    class Task < Hash
      include Hashie::Extensions::MethodAccess

      def initialize(options = {})
        self.merge!(options)
      end

      # Note this overrides Hash#update. Use Hash#merge! instead.
      def update(options = {})
        self.merge!(Vermonster::Client.connection.put("tasks/#{self["id"]}", "{\"task\": #{options.to_json}}").body)
      end

      class << self
        def from_list(id)
          tasks_raw = Vermonster::Client.connection.get("lists/#{id}/tasks").body
          tasks = []
          tasks_raw.each do |task|
            tasks.push(Task.new(task))
          end

          tasks
        end

        def find(id)
          Task.new(Vermonster::Client.connection.get("tasks/#{id}").body)
        end

        def create(options = {})
        end

        def reorder(options = {})
        end
      end
    end
  end
end
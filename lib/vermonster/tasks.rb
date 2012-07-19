module Vermonster
  module Tasks
    def tasks
      self.class::Task
    end

    class Task < Hash
      def initialize(options = {})
        self.merge!(options)

        options.each do |(attr, val)|
          instance_variable_set("@#{attr}", val)
          instance_eval "def #{attr}() @#{attr} end"
        end
      end

      # Note this overrides Hash#update. Use Hash#merge! instead.
      def update(options = {})
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
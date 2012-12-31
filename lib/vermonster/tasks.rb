module Vermonster
  module Tasks
    def tasks
      self.class::Task
    end

    # A Task inside of a List.
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
        self.merge!(Vermonster::Client.connection.put("tasks/#{self["id"]}", "{\"task\": #{options.to_json}}").body)
      end

      def move(list)
        self.replace(Vermonster::Client.connection.put("tasks/#{self["id"]}/move", "{\"task\": { \"list_id\": #{list} } }").body)
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

        def create(list, options = {})
          Task.new(Vermonster::Client.connection.post("lists/#{list}/tasks", "{\"task\": #{options.to_json}}").body)
        end

        def reorder(list, options = {})
        end

        def archive(list)
          Vermonster::Client.connection.post("lists/#{list}/tasks/archive_completed")
        end

        def archive!(list)
          Vermonster::Client.connection.post("lists/#{list}/tasks/archive_all")
        end
      end
    end
  end
end
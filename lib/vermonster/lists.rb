module Vermonster
  module Lists
    def lists
      self.class::List
    end

    class List < Hash
      def initialize(options = {})
        self.merge!(options)

        options.each do |(attr, val)|
          instance_variable_set("@#{attr}", val)
          instance_eval "def #{attr}() @#{attr} end"
        end
      end

      # Note this overrides Hash#update. Use Hash#merge! instead.
      def update(options = {})
        self.merge!(Vermonster::Client.connection.put("lists/#{self["id"]}", "{\"list\": #{options.to_json}}").body)
      end

      def tasks
        Vermonster::Tasks::Task.from_list(self["id"])
      end

      class << self
        def all
          lists_raw = Vermonster::Client.connection.get("lists").body
          lists = []
          lists_raw.each do |list|
            lists.push(List.new(list))
          end

          lists
        end

        def find(id)
          List.new(Vermonster::Client.connection.get("lists/#{id}").body)
        end

        def create(options = {})
          List.new(Vermonster::Client.connection.post("lists", "{\"list\": #{options.to_json}}").body)
        end

        def reorder(lists)
        end
      end
    end
  end
end
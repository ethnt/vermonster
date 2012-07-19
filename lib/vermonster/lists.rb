module Vermonster
  module Lists
    def lists
      self.class::List
    end

    class List < Hash
      def initialize(options = {})
        self.merge!(options)
      end

      # Note this overrides Hash#update. Use Hash#merge! instead.
      def update(options = {})
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
        end

        def reorder(options = {})
        end
      end
    end
  end
end
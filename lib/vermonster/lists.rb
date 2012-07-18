module Vermonster
  module Lists
    def lists
      self.class::List
    end

    class List
      def initialize(options = {})
      end

      def update(options = {})
      end

      class << self
        def all
        end

        def find(id)
        end

        def create(options = {})
        end

        def reorder(options = {})
        end
      end
    end 
  end
end
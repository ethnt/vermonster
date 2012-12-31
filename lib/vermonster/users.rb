module Vermonster
  module Users
    def me
      self.users.me
    end

    def users
      self.class::User
    end

    # A Cheddar User.
    class User < Hash
      def initialize(options = {})
        self.merge!(options)

        options.each do |(attr, val)|
          instance_variable_set("@#{attr}", val)
          instance_eval "def #{attr}() @#{attr} end"
        end
      end

      def self.me
        User.new(Vermonster::Client.connection.get("me").body)
      end
    end
  end
end


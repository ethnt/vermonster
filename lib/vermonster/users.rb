module Vermonster
  module Users
    # Get information about authorized user (shortcut to ::Users.users.me).
    def me
      self.users.me
    end

    def users
      self.class::User
    end

    class User < Hash
      def initialize(options = {})
        self.merge!(options)

        options.each do |(attr, val)|
          instance_variable_set("@#{attr}", val)
          instance_eval "def #{attr}() @#{attr} end"
        end
      end

      # Get information about authorized user.
      def self.me
        User.new(Vermonster::Client.connection.get("me").body)
      end
    end
  end
end


module Vermonster
  module Users
    def me
      self.users.me
    end

    def users
      self.class::User
    end

    class User < Hash
      include Hashie::Extensions::MethodAccess

      def initialize(options = {})
        self.merge!(options)
      end

      def self.me
        User.new(Vermonster::Client.connection.get("me").body)
      end
    end
  end
end


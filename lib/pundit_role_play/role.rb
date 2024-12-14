# frozen_string_literal: true

require_relative "permissions"

module PunditRolePlay
  class Role
    def self.inherited(subclass)
      super

      PunditRolePlay.register_role(subclass.name)
    end

    def self.permissions
      Permissions.new(self)
    end
  end
end

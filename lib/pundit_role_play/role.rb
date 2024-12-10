# frozen_string_literal: true

require_relative "permissions"

module PunditRolePlay
  class Role
    # TODO: Define the roles somewhere - perhaps in a config file

    def self.permissions
      Permissions.new(self)
    end
  end
end

# frozen_string_literal: true

module PunditRolePlay
  class Permissions
    attr_reader :permissions

    def initialize(role)
      @permissions = role::PERMISSIONS
    rescue TypeError => e
      # Handle the case where the role is nil
      raise e unless role.nil?

      @permissions = {}
    end

    def can?(operation, resource)
      # If you can write to a resource, you can also read from it
      return true if permissions[resource.to_sym] == :write

      permissions[resource.to_sym] == operation.to_sym
    end

    def [](resource)
      permissions[resource.to_sym]
    end
  end
end

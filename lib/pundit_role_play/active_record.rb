# frozen_string_literal: true

module PunditRolePlay
  module ActiveRecord
    def has_pundit_role
      include PunditRolePlay::ActiveRecordMethods
    end
  end

  module ActiveRecordMethods
    def role
      value = super

      return nil unless value.present?

      value.constantize

      value
    rescue NameError
      # Handle the case where the string can't be converted to a constant
      # eg. "testrole" (which should be "TestRole")
      #
      # Handle the case where the constant does not exist
      raise RoleNotFoundError
    end

    def pretty_role_name
      role.gsub(/Role/, "")
    end

    def permissions
      role.constantize.permissions
    rescue NoMethodError
      Permissions.new(nil)
    end
  end
end

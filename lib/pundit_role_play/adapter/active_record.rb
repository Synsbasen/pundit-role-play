# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module PunditRolePlay
  module Adapter
    module ActiveRecord
      def has_pundit_role
        include PunditRolePlay::Adapter::ActiveRecordMethods
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

      def has_role?(role)
        role.to_sym == self.role.underscore.sub(/_role$/, '').to_sym
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
end

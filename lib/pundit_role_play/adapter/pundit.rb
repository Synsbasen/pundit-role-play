# frozen_string_literal: true

module PunditRolePlay
  module Adapter
    module Pundit
      def can_read?(resource: self.class.to_s.gsub("Policy", "").pluralize.underscore)
        user&.permissions&.can?(:read, resource.to_sym) || false
      end

      def can_write?(resource: self.class.to_s.gsub("Policy", "").pluralize.underscore)
        user&.permissions&.can?(:write, resource.to_sym) || false
      end
    end
  end
end

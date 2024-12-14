# frozen_string_literal: true

require "rails/generators"

module PunditRolePlay
  module Generators
    class RoleGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      argument :role_name, type: :string, required: true, banner: "Role name"

      def create_role_file
        # Generate the role file in app/roles
        template "role.rb", File.join("app/roles", "#{file_name}.rb")
      end

      private

      # Ensure the class name ends with "Role"
      def class_name
        role_name.camelize.end_with?("Role") ? role_name.camelize : "#{role_name.camelize}Role"
      end

      # Convert the class name to a file name
      def file_name
        class_name.underscore
      end
    end
  end
end


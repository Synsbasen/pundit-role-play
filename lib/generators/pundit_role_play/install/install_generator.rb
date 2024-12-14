# frozen_string_literal: true

require "rails/generators"

module PunditRolePlay
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_roles_folder
        empty_directory "app/roles"
      end

      def create_application_role
        template "application_role.rb", "app/roles/application_role.rb"
      end

      def display_readme
        readme "README.md" if behavior == :invoke
      end
    end
  end
end

# frozen_string_literal: true

module PunditRolePlay
  class Railtie < Rails::Railtie
    initializer 'pundit_role_play.eager_load_roles' do |app|
      # Force Rails to load all role files
      role_path = Rails.root.join("app", "roles")

      Dir["#{role_path}/**/*.rb"].each do |file|
        require_dependency file
      end
    end
  end
end

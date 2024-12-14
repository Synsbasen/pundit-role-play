# frozen_string_literal: true

module PunditRolePlay
  class Railtie < Rails::Railtie
    initializer "pundit_role_play.eager_load_roles" do
      # Force Rails to load all role files
      role_path = Rails.root.join("app", "roles")

      Dir["#{role_path}/**/*.rb"].each do |file|
        require_dependency file
      end
    end

    initializer "pundit_role_play.extend_active_record" do
      ActiveSupport.on_load(:active_record) do
        extend PunditRolePlay::ActiveRecord
      end
    end

    initializer "pundit_role_play.extend_application_policy" do
      Rails.application.config.to_prepare do
        if defined?(ApplicationPolicy)
          ApplicationPolicy.include(PunditRolePlay::Pundit)
        end
      end
    end
  end
end

# frozen_string_literal: true

require "rails/railtie"

module PunditRolePlay
  class Railtie < Rails::Railtie
    config.before_configuration do
      # Add app/roles to eager_load_paths early
      Rails.application.config.eager_load_paths << Rails.root.join("app", "roles")
    end

    initializer "pundit_role_play.extend_active_record" do
      ActiveSupport.on_load(:active_record) do
        extend PunditRolePlay::Adapter::ActiveRecord
      end
    end

    initializer "pundit_role_play.extend_application_policy" do
      Rails.application.config.to_prepare do
        if defined?(ApplicationPolicy)
          ApplicationPolicy.include(PunditRolePlay::Adapter::Pundit)
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative "pundit_role_play/version"
require_relative "pundit_role_play/role"
require_relative "pundit_role_play/models"

module PunditRolePlay
  class Error < StandardError; end
  class RoleNotFoundError < Error
    def message
      "Role does not exist"
    end
  end

  if defined?(Rails)
    ActiveSupport.on_load(:active_record) do
      extend PunditRolePlay::Models
    end
  end
end

# TODO
# - [ ] Define the roles somewhere - perhaps in a config file
# - [x] Add model helpers to get role and check permissions
#   - [x] Make sure that an error is raised if the role does not exist
#   - [x] Make sure that permissions does not raise an error if the role is blank
# - [ ] Add Pundit integration (like in BI)

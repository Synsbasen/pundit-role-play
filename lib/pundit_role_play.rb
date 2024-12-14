# frozen_string_literal: true

require_relative "pundit_role_play/adapter/active_record"
require_relative "pundit_role_play/adapter/pundit"
require_relative "pundit_role_play/railtie"
require_relative "pundit_role_play/role"
require_relative "pundit_role_play/version"

module PunditRolePlay
  class Error < StandardError; end
  class RoleNotFoundError < Error
    def message
      "Role does not exist"
    end
  end

  def self.roles
    @roles ||= []
  end

  def self.register_role(name)
    roles << name unless name == "ApplicationRole"
  end
end

# TODO
# - [x] Define the roles somewhere - perhaps in a config file
#   - We list the roles a few places in Synsbasen BI so we need to get a list of available roles somehow
# - [x] Add model helpers to get role and check permissions
#   - [x] Make sure that an error is raised if the role does not exist
#   - [x] Make sure that permissions does not raise an error if the role is blank
# - [x] Add Pundit integration (like in BI)
#   - [x] Module to be included
#   - [x] Automatically include the module in ApplicationPolicy when the gem loads (like we do for ActiveRecord)
# - [ ] Add Rails generator (rails g pundit_role_play:install) to create the app/roles folder and add an ApplicationRole
# - [ ] Add Rails generator (rails g pundit_role_play:role <role_name>) to add a new role

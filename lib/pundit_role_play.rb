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
    roles.uniq!
  end
end

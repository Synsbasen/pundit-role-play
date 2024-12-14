class <%= class_name %> < ApplicationRole
  PERMISSIONS = {
    users: :read,
    another_resource: :write
  }.freeze
end


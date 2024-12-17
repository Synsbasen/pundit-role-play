# Pundit Role Play

A simple and flexible role-based authorization gem built on top of **Pundit** for Ruby on Rails applications. Pundit Role Play allows developers to manage user roles and permissions in an intuitive way while leveraging Pundit's policy-driven architecture.

## Features
- Easy role management for users.
- Built-in support for Pundit policies.
- Flexible and lightweight design with minimal dependencies.
- Supports role inheritance and custom roles.

## Installation
Add the gem to your Rails application's `Gemfile`:

```ruby
gem "pundit_role_play", github: "Synsbasen/pundit-role-play", branch: "master"
```

Run the bundle command to install it:

```bash
bundle install
```

Run the install generator to setup an application role:
```bash
bin/rails generate pundit_role_play:install
```

## Preconditions
Ensure that the models you want to use roles and permissions with have a `role` attribute. This attribute should be a string and should be present in the database.

```ruby
class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string #, default: "MemberRole"
  end
end
```

Furthermore, ensure that the `has_pundit_role` method is called in the User model.

```ruby
class User < ApplicationRecord
  has_pundit_role
end
```

## Usage
### Setting up Roles
Define roles for your application by utilizing the built-in role generator:

```bash
bin/rails generate pundit_role_play:role admin
```

This will generate the following role:

```ruby
class AdminRole < ApplicationRole
  PERMISSIONS = {
    users: :read,
    another_resource: :write
  }.freeze
end
```

Now, it's up to you to define the resources for the role. Example:

```ruby
class AdminRole < ApplicationRole
  PERMISSIONS = {
    areas: :write,
    invoices: :read,
    organizations: :write,
    user_areas: :write,
    users: :write,
    user_organizations: :write
  }.freeze
end
```

### Using roles in Pundit policies
Pundit Role Play integrates seamlessly with Pundit policies. Use the current user's permissions within your Pundit policy files with the `can_read?` and `can_write?` helper methods:

```ruby
class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    can_write? || user == record
  end

  def index?
    can_read?
  end

  def show?
    can_read?
  end

  def new?
    can_write?
  end

  def create?
    can_write?
  end

  def update?
    can_write? || user == record
  end
end
```

PunditRolePlay knows which resource from the role's permissions to target based on the name of the policy. In the example above it will target the `users` resource and evaluate if read/write is allowed.

The `can_edit?` and `can_write?` methods takes an optional argument `:resource` in case you're working with a policy that depends on other resources. Example:

```ruby
class UserOrganizationPolicy < ApplicationPolicy
  def edit?
    can_write?(resource: :users)
  end
end
```

### Checking roles in controllers
You can use the role helper methods in your controllers:

```ruby
class PostsController < ApplicationController
  def update
    if current_user.has_role?(:editor)
      # Proceed with update logic
    else
      redirect_to root_path, alert: 'Access Denied!'
    end
  end
end
```

### Role helper in views
You can use the role helper methods in your views:

```erb
<% if current_user.has_role?(:admin) %>
  <%= link_to 'Delete Post', post_path(@post), method: :delete %>
<% end %>
```

## Role inheritance
Pundit Role Play supports role inheritance out of the box. For example:

- **Admin** inherits permissions from **Manager** and **Editor**.
- **Manager** inherits permissions from **Editor**.

This means an admin user will automatically have all the permissions of a manager and editor.

## Contributing
We welcome contributions! Please fork the repository, make changes, and submit a pull request.

### Steps to contribute
1. Fork the repository.
2. Create a new branch for your feature: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add new feature'`.
4. Push the branch: `git push origin my-new-feature`.
5. Submit a pull request.

## License
This gem is released under the [MIT License](LICENSE).

## Support
If you encounter any issues, please open an issue in the GitHub repository.

---

**Pundit Role Play** simplifies role-based authorization for Pundit users. Get started today and make authorization in your Rails app clean, flexible, and powerful!


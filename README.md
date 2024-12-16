# PunditRolePlay

Ever wanted to have a simple way to manage roles and permissions in your Rails application? This gem is for you! It provides a simple way to manage roles and permissions using Pundit. All you need to do is define your roles and permissions and then use the `can_read?` and `can_write?` methods in your policies.

## Installation
Install the gem by adding it to your Gemfile and run `bundle install`:

```
gem "pundit_role_play", github: "Synsbasen/pundit-role-play", branch: "master"
```

Run the generator to setup an application role:

```
bundle exec rails generate pundit_role_play:install
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

Create a new role:

```
bundle exec rails generate pundit_role_play:role admin
```

Then define the permissions based on your resources.

In your policies you can now use the `can_read?` and `can_write?` methods to check if a user has the required permissions.

Example:

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pundit_role_play. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/pundit_role_play/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PunditRolePlay project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Synsbasen/pundit_role_play/blob/master/CODE_OF_CONDUCT.md).

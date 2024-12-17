# frozen_string_literal: true

require_relative "lib/pundit_role_play/version"

Gem::Specification.new do |spec|
  spec.name = "pundit_role_play"
  spec.version = PunditRolePlay::VERSION
  spec.authors = [ "Jimmy Poulsen", "Tobias Knudsen" ]
  spec.email = [ "jimmypoulsen96@gmail.com", "tobias.knudsen@gmail.com" ]

  spec.summary = "A simple role based authorization gem for Pundit"
  spec.description = "This gem is a simple role based authorization gem for Pundit.
    It allows you to define roles and permissions in a simple way and use them in your Pundit policies."
  spec.homepage = "https://github.com/synsbasen/pundit-role-play"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  spec.add_dependency "rails", ">= 7.0.0"
end

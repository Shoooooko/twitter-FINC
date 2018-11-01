# -*- encoding: utf-8 -*-
# stub: rubocop-automata 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop-automata".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["rvillage".freeze]
  s.date = "2017-12-31"
  s.description = "Create GitHub PullRequest of rubocop --auto-correct in CircleCI".freeze
  s.email = ["rvillage@gmail.com".freeze]
  s.executables = ["rubocop-automata".freeze]
  s.files = ["bin/rubocop-automata".freeze]
  s.homepage = "https://github.com/rvillage/rubocop-automata".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Create GitHub PullRequest of rubocop --auto-correct in CircleCI".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubocop>.freeze, ["~> 0.51"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
    else
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.51"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    end
  else
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.51"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
  end
end

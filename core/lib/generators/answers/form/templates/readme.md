# <%= extension_plural_name.titleize %> form extension for Answers.

## How to build this extension as a gem (not required)

    cd vendor/extensions/<%= extension_plural_name %>
    gem build answers-<%= extension_plural_name %>.gemspec
    gem install answers-<%= extension_plural_name %>.gem

    # Sign up for a http://rubygems.org/ account and publish the gem
    gem push answers-<%= extension_plural_name %>.gem

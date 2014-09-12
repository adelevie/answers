# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'answers-<%= plural_name %>'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails <%= plural_name.titleize %> forms-extension for Answers'
  s.date              = '<%= Time.now.strftime('%Y-%m-%d') %>'
  s.summary           = '<%= plural_name.titleize %> forms-extension for Answers'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency    'answers-core',     '~> <%= Answers::Version %>'
  s.add_dependency    'answers-settings', '~> <%= [Answers::Version.major, Answers::Version.minor, 0].join(".") %>'
end

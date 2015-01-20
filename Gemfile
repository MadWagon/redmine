source 'https://rubygems.org'

gem "rails", "3.2.21"
gem "jquery-rails", "~> 3.1.1"
gem "coderay", "~> 1.1.0"
gem "fastercsv", "~> 1.5.0", :platforms => [:mri_18, :mingw_18, :jruby]
gem "builder", ">= 3.0.4"
gem "request_store", "1.0.5"
gem "mime-types"
gem "rbpdf", "~> 1.18.4"

gem "i18n", "~> 0.6.11"

# Deploy with Capistrano
gem 'capistrano', "~> 2.14.2"

# Optional gem for LDAP authentication
group :ldap do
  gem "net-ldap", "~> 0.3.1"
end

# Optional gem for OpenID authentication
group :openid do
  gem "ruby-openid", "~> 2.3.0", :require => "openid"
  gem "rack-openid"
end

platforms :mri, :mingw do
  # Optional gem for exporting the gantt to a PNG file, not supported with jruby
  group :rmagick do
    # RMagick 2 supports ruby 1.9
    # RMagick 1 would be fine for ruby 1.8 but Bundler does not support
    # different requirements for the same gem on different platforms
    gem "rmagick", (RUBY_VERSION < "1.9" ? "2.13.3" : ">= 2.0.0")
  end

  # Optional Markdown support, not for JRuby
  group :markdown do
    # TODO: upgrade to redcarpet 3.x when ruby1.8 support is dropped
    gem "redcarpet", "~> 2.3.0"
  end
end

platforms :jruby do
  # jruby-openssl is bundled with JRuby 1.7.0
  gem "jruby-openssl" if Object.const_defined?(:JRUBY_VERSION) && JRUBY_VERSION < '1.7.0'
  gem "activerecord-jdbc-adapter", "~> 1.3.2"
end

# Include database gems for the adapters found in the database
# configuration file
require 'erb'
require 'yaml'


#gem "mysql", "~> 2.8.1", :platforms => [:mri, :mingw]
gem 'mysql2'
#gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
gem  "activerecord-mysql2-adapter"

group :development do
  gem "rdoc", ">= 2.4.2"
  gem "yard"
end

group :test do
  gem "shoulda", "~> 3.3.2"
  gem "shoulda-matchers", "1.4.1"
  gem "mocha", "~> 1.0.0", :require => 'mocha/api'
  if RUBY_VERSION >= '1.9.3'
    gem "capybara"
    gem "selenium-webdriver"
  end
end

local_gemfile = File.join(File.dirname(__FILE__), "Gemfile.local")
if File.exists?(local_gemfile)
  puts "Loading Gemfile.local ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(local_gemfile)
end

# Load plugins' Gemfiles
#Dir.glob File.expand_path("../plugins/*/{Gemfile,PluginGemfile}", __FILE__) do |file|
 # puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  #TODO: switch to "eval_gemfile file" when bundler >= 1.2.0 will be required (rails 4)
  #instance_eval File.read(file), file
#end

# Better add gem for plugin manually since capistrano
gem "redmine_acts_as_taggable_on", "~> 1.0"
gem "rubocop", "~> 0.26.1"


ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

#ansachs added this line to force development
# ENV['RAILS_ENV'] = 'development'

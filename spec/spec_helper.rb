require 'middleman'
require 'middleman-syntax'
require 'middleman-s3_redirect'
require 'contentful_middleman'
require 'rspec'
require 'capybara/rspec'
require 'pry'
require 'cgi'

Dir[File.dirname(__FILE__) + '/shared/*.rb'].each { |file| require file }

Capybara.app = Middleman::Application.server.inst do
  set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
  set :environment, :development
  set :show_exceptions, false
end

# frozen_string_literal: true

require 'rack'
require 'rack/contrib'
require_relative './server'

set :root, File.dirname(__FILE__)
set :views, proc { File.join(root, 'views') }

run Sinatra::Application

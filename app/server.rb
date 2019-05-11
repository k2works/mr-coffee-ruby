# frozen_string_literal: true

require "sinatra/base"
require "sinatra/reloader"
require "json"
require "aws-record"
require "active_record"
require "require_all"

ENV["SINATRA_ENV"] ||= "development"
ENV["API_URL"] ||= "http://127.0.0.1:9393/api"
ENV["AWS_DEFAULT_REGION"] ||= "us-east-1"
ENV["AWS_ACCESS_KEY_ID"] ||= "XXXXXXXXXXXXXXXXXXXX"
ENV["AWS_SECRET_ACCESS_KEY"] ||= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
ENV["DB_ENDPOINT"] ||= "http://localhost:8000"

require "bundler/setup"
Bundler.require(:default, ENV["SINATRA_ENV"])

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3", database: "db/#{ENV['SINATRA_ENV']}.sqlite"
)

Aws.config.update(
  credentials:
    Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
)
Aws.config.update(region: ENV["AWS_DEFAULT_REGION"])
Aws.config.update(endpoint: ENV["DB_ENDPOINT"])

class App < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
    set :views, proc { File.join(root, "views") }
  end

  before do
    if !request.body.read.empty? && !request.body.empty?
      request.body.rewind
      @params = Sinatra::IndifferentHash.new
      @params.merge!(JSON.parse(request.body.read))
    end
  end

  ##################################
  # For the index page
  ##################################
  get "/" do
    erb :index
  end

  get "/contact" do
    erb :contact
  end
  ##################################
  # Return a Hello world JSON
  ##################################
  get "/hello-world" do
    content_type :json
    { Output: "Hello World!" }.to_json
  end

  post "/hello-world" do
    content_type :json
    { Output: "Hello World!" }.to_json
  end
end

# frozen_string_literal: true

require "sinatra/base"
require "sinatra/reloader"

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

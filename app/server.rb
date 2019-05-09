# frozen_string_literal: true

require "sinatra"

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

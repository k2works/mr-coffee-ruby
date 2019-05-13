# frozen_string_literal: true

require 'spec_helper'

# Tests for server.rb
describe 'HelloWorld Service' do
  include Rack::Test::Methods

  # Test for HTTP GET for URL-matching pattern '/'
  it 'should return successfully on GET' do
    get '/hello-world'
    expect(last_response).to be_ok
    json_result = JSON.parse(last_response.body)
    expect(json_result['Output']).to eq('Hello World!')
  end

  # Test for HTTP POST for URL-matching pattern '/'
  it 'should return successfully on POST' do
    post '/hello-world'
    expect(last_response).to be_ok
    expect(json_result['Output']).to eq('Hello World!')
  end
end

describe 'Contact Api' do
  include Rack::Test::Methods

  it '問い合わせテーブルを作る' do
    post '/api/contact/create'
    expect(last_response).to be_ok
    expect(json_result['Message']).to eq('問い合わせテーブルを作成しました')
  end

  it '問い合わせ内容を送信する' do
    post '/api/contact/save'
    expect(last_response).to be_ok
    expect(json_result['Message']).to eq('問い合わせを送信しました')
  end

  it '問い合わせテーブルを削除する' do
    post '/api/contact/drop'
    expect(last_response).to be_ok
    expect(json_result['Message']).to eq('問い合わせテーブルを削除しました')
  end
end

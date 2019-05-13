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

  let(:api_requests) { [] }

  def configure_test_client(client)
    requests = api_requests
    client.handle do |context|
      requests << context.params
      @handler.call(context)
    end
    client
  end

  it '問い合わせテーブルを作る' do
    post '/api/contact/create'

    cfg = Aws::Record::TableConfig.define do |t|
      t.model_class(Contact)
      t.read_capacity_units(1)
      t.write_capacity_units(1)
      t.client_options(stub_responses: true)
    end

    stub_client = configure_test_client(cfg.client)
    stub_client.stub_responses(
      :describe_table,
      'ResourceNotFoundException',
      table: { table_status: 'ACTIVE' }
    )
    cfg.migrate!
    expect(api_requests[1]).to eq(
      table_name: 'Contact',
      provisioned_throughput:
          {
            read_capacity_units: 1,
            write_capacity_units: 1
          },
      key_schema: [
        {
          attribute_name: 'id',
          key_type: 'HASH'
        },
        {
          attribute_name: 'name',
          key_type: 'RANGE'
        }
      ],
      attribute_definitions: [
        {
          attribute_name: 'id',
          attribute_type: 'N'
        },
        {
          attribute_name: 'name',
          attribute_type: 'S'
        }
      ]
    )
    expect(last_response).to be_ok
    expect(json_result['Message']).to eq('問い合わせテーブルを作成しました')
  end

  it '問い合わせ内容を送信する' do
    params = {
        name: 'お名前',
        email: 'mail@hoge.com',
        questionnaire: 'answer1',
        category: 'category1',
        message: 'メッセージ'
    }
    post '/api/contact/save', params
    expect(last_response).to be_ok
    expect(json_result['Message']).to eq('問い合わせを送信しました')
  end

  it '問い合わせテーブルを削除する' do
    post '/api/contact/drop'
    expect(last_response).to be_ok
    expect(json_result['Message']).to eq('問い合わせテーブルを削除しました')
  end
end

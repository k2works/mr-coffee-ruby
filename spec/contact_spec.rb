# frozen_string_literal: true

require 'spec_helper'

describe 'Contact Service' do
  include Rack::Test::Methods

  let(:api_requests) { [] }
  let(:stub_client) do
    requests = api_requests
    client = Aws::DynamoDB::Client.new(stub_responses: true)
    client.handle do |context|
      requests << context.params
      @handler.call(context)
    end
    client
  end

  def configure_test_client(client)
    requests = api_requests
    client.handle do |context|
      requests << context.params
      @handler.call(context)
    end
    client
  end

  it '問い合わせテーブルを作る' do
    service = ContactService.new
    stub_client = configure_test_client(service.cfg.client)
    stub_client.stub_responses(
      :describe_table,
      'ResourceNotFoundException',
      table: { table_status: 'ACTIVE' }
    )
    service.create
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
  end

  it '問い合わせ内容を送信する' do
    params = {
      name: 'お名前',
      email: 'mail@hoge.com',
      questionnaire: 'answer1',
      category: 'category1',
      message: 'メッセージ'
    }
    service = ContactService.new(stub: stub_client)
    item = service.item
    expect(item.new_record?).to be(true)
    item.id = 1
    item.ts = 1
    service.save(params)
    expect(item.new_record?).to be(false)
    expect(api_requests).to eq([{
                                 condition_expression: 'attribute_not_exists(#H) and attribute_not_exists(#R)',
                                 expression_attribute_names: { '#H' => 'id', '#R' => 'name' },
                                 item: { 'category' => { s: 'category1' },
                                         'email' => { s: 'mail@hoge.com' },
                                         'id' => { n: '1' },
                                         'message' => { s: 'メッセージ' },
                                         'name' => { s: 'お名前' },
                                         'questionnaire' => { s: 'answer1' },
                                         'ts' => { n: '1' } },
                                 table_name: 'Contact'
                               }])
  end

  it '問い合わせテーブルを削除する' do
    service = ContactService.new(stub: stub_client)
    service.drop
    expect(api_requests).to eq([{
                                 table_name: 'Contact'
                               }])
  end
end

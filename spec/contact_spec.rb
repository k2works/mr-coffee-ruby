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
    stub_client = configure_test_client(service.cfg_client)
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
    service.save(params)
    result = service.find({id:1, name:"お名前"})
    expect(api_requests.last).to eq( {:key=>{"id"=>{:n=>"1"}, "name"=>{:s=>"お名前"}}, :table_name=>"Contact"})
  end

  it '問い合わせテーブルを削除する' do
    service = ContactService.new(stub: stub_client)
    service.drop
    expect(api_requests).to eq([{
                                 table_name: 'Contact'
                               }])
  end

  it '問い合わせ内容一覧を取得する' do
    service = ContactService.new(stub: stub_client)
    stub_client = configure_test_client(service.cfg_client)
    stub_client.stub_responses(:scan,
                               items: [
                                 {
                                   'category' => { s: 'category1' },
                                   'email' => { s: 'mail@hoge.com' },
                                   'id' => { n: '1' },
                                   'message' => { s: 'メッセージ' },
                                   'name' => { s: 'お名前' },
                                   'questionnaire' => { s: 'answer1' },
                                   'ts' => { n: '1' }
                                 },
                                 {
                                   'category' => { s: 'category1' },
                                   'email' => { s: 'mail@hoge.com' },
                                   'id' => { n: '2' },
                                   'message' => { s: 'メッセージ' },
                                   'name' => { s: 'お名前' },
                                   'questionnaire' => { s: 'answer1' },
                                   'ts' => { n: '1' }
                                 }
                               ],
                               count: 2,
                               scanned_count: 2,
                               last_evaluated_key: nil)
    result = service.select_all
    expect(api_requests).to eq([{ table_name: 'Contact' }])
  end
end

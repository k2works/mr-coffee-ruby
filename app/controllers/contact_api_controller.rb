# frozen_string_literal: true

class App < Sinatra::Base
  configure { enable :cross_origin }

  ##################################
  # Return JSON
  ##################################
  post "/api/contact/create" do
    content_type :json
    headers "Access-Control-Allow-Origin" => "*"

    service = ContactService.new
    service.create
    { Message: "問い合わせテーブルを作成しました" }.to_json
  end

  post "/api/contact/save" do
    content_type :json
    headers "Access-Control-Allow-Origin" => "*"

    service = ContactService.new
    service.save(params)
    { Message: "問い合わせを送信しました" }.to_json
  end

  post "/api/contact/drop" do
    content_type :json
    headers "Access-Control-Allow-Origin" => "*"

    service = ContactService.new
    service.drop
    { Message: "問い合わせテーブルを削除しました" }.to_json
  end

  post "/api/contact/seed" do
    content_type :json
    headers "Access-Control-Allow-Origin" => "*"

    service = ContactService.new
    service.seed
    { Message: "ダミーデータを作成しました" }.to_json
  end

  post "/api/contact/select_all" do
    content_type :json
    headers "Access-Control-Allow-Origin" => "*"

    service = ContactService.new
    result = service.select_all
    result.to_json
  end
end

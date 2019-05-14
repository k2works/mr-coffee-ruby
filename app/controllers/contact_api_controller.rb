# frozen_string_literal: true

class App < Sinatra::Base
  ##################################
  # Return JSON
  ##################################
  post "/api/contact/create" do
    content_type :json
    service = ContactService.new
    service.create
    { Message: "問い合わせテーブルを作成しました" }.to_json
  end

  post "/api/contact/save" do
    content_type :json
    service = ContactService.new
    service.save(params)
    { Message: "問い合わせを送信しました" }.to_json
  end

  post "/api/contact/drop" do
    content_type :json
    service = ContactService.new
    service.drop
    { Message: "問い合わせテーブルを削除しました" }.to_json
  end
end

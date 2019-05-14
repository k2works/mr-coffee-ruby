# frozen_string_literal: true

class App < Sinatra::Base
  configure do
    if ENV["SINATRA_ENV"] == "production"
      set views: "views"
      set public_folder: "views/public"
    else
      set views: "app/views"
      set public_folder: "app/views/public"
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

  post "/contact" do
    item = Contact.new(id: SecureRandom.uuid, ts: Time.now)
    item.name = params[:name]
    item.email = params[:email]
    item.questionnaire = params[:questionnaire]
    item.category = params[:category]
    item.message = params[:message]
    item.save!

    @message = "お問い合わせを送信しました"
    erb :contact
  end
end

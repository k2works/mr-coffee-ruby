class App < Sinatra::Base
  configure do
    if ENV["SINATRA_ENV"] == "production"
      set :views => 'views'
      set :public_folder => 'views/public'
    else
      set :views => 'app/views'
      set :public_folder => 'app/views/public'
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

# frozen_string_literal: true

class App < Sinatra::Base
  configure do
    if ENV['SINATRA_ENV'] == 'production'
      set views: 'views'
      set public_folder: 'views/public'
    else
      set views: 'app/views'
      set public_folder: 'app/views/public'
    end
  end

  def set_api_url
    @api_url =
      if ENV['SINATRA_ENV'] == 'production'
        ENV['API_URL']
      else
        'http://localhost:9292'
      end
  end

  ##################################
  # For the index page
  ##################################
  get '/' do
    erb :index
  end

  get '/contact' do
    erb :contact
  end

  post '/contact' do
    item = Contact.new(id: SecureRandom.uuid, ts: Time.now)
    item.name = params[:name]
    item.email = params[:email]
    item.questionnaire = params[:questionnaire]
    item.category = params[:category]
    item.message = params[:message]
    item.save!

    @message = 'お問い合わせを送信しました'
    erb :contact
  end

  get '/admin' do
    erb :"admin/index.html"
  end

  get '/admin-contact' do
    set_api_url
    erb :"admin/contact.html"
  end

  get '/admin-system' do
    set_api_url
    erb :"admin/system.html"
  end

  get '/admin-buttons' do
    erb :'admin/buttons.html'
  end

  get '/admin-cards' do
    erb :'admin/cards.html'
  end

  get '/admin-utilities-color' do
    erb :'admin/utilities-color.html'
  end

  get '/admin-utilities-border' do
    erb :'admin/utilities-border.html'
  end

  get '/admin-utilities-animation' do
    erb :'admin/utilities-animation.html'
  end

  get '/admin-utilities-other' do
    erb :'admin/utilities-other.html'
  end

  get '/admin-login' do
    erb :'admin/login.html'
  end

  get '/admin-register' do
    erb :'admin/register.html'
  end

  get '/admin-forgot-password' do
    erb :'admin/forgot-password.html'
  end

  get '/admin-404' do
    erb :'admin/404.html'
  end

  get '/admin-blank' do
    erb :'admin/blank.html'
  end

  get '/admin-charts' do
    erb :'admin/charts.html'
  end

  get '/admin-tables' do
    erb :'admin/tables.html'
  end
end

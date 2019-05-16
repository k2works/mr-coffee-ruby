# frozen_string_literal: true

class ContactRepository
  attr_reader :cfg, :item

  def initialize(opt = {})
    @model = Contact
    @cfg =
      Aws::Record::TableConfig.define do |t|
        t.model_class(Contact)
        t.read_capacity_units(1)
        t.write_capacity_units(1)
        t.client_options(stub_responses: true) if ENV['APP_ENV'] == 'test'
      end

    @model.configure_client(client: opt[:stub]) if ENV['APP_ENV'] == 'test'
    @migration =
      if ENV['APP_ENV'] == 'test'
        Aws::Record::TableMigration.new(Contact, client: opt[:stub])
      else
        Aws::Record::TableMigration.new(Contact)
      end
  end

  def new
    @item = @model.new(id: SecureRandom.uuid, ts: Time.now)
  end

  def create
    @cfg.migrate!
  end

  def save(params)
    @item.name = params[:name]
    @item.email = params[:email]
    @item.questionnaire = params[:questionnaire]
    @item.category = params[:category]
    @item.message = params[:message]
    @item.save!
  end

  def drop
    @migration.delete!
  end

  def seed
    (1..10).each do |i|
      param = {
        id: i,
        name: Faker::JapaneseMedia::SwordArtOnline.game_name,
        email: Faker::Internet.email,
        questionnaire: "answer#{i}",
        category: "category#{i}",
        message: Faker::JapaneseMedia::SwordArtOnline.item
      }
      save(param)
    end
  end

  def select_all
    @model.scan.to_a.map do |item|
      {
        id: item.id.to_i,
        name: item.name,
        email: item.email,
        questionnaire: item.questionnaire,
        category: item.category,
        message: item.message
      }
    end
  end
end

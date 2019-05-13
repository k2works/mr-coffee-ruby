# frozen_string_literal: true

class ContactService
  attr_reader :cfg, :item

  def initialize(opt = {})
    @cfg =
      Aws::Record::TableConfig.define do |t|
        t.model_class(Contact)
        t.read_capacity_units(1)
        t.write_capacity_units(1)
        t.client_options(stub_responses: true) if ENV['APP_ENV'] == 'test'
      end

    Contact.configure_client(client: opt[:stub]) if ENV['APP_ENV'] == 'test'
    @item = Contact.new(id: SecureRandom.uuid, ts: Time.now)
    @migration = Aws::Record::TableMigration.new(Contact, client: opt[:stub]) if ENV['APP_ENV'] == 'test'
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
end

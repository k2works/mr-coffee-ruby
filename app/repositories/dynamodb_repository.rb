# frozen_string_literal: true

class DynamodbRepository
  attr_reader :cfg, :item, :model

  def initialize(opt = {})
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

  def create
    @cfg.migrate!
  end

  def drop
    @migration.delete!
  end

  def new
    @model.new(id: SecureRandom.uuid, ts: Time.now)
  end

  def save
    raise 'Implement method!'
  end

  def find
    raise 'Implement method!'
  end
end

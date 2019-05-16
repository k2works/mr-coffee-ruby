# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration
  def up
    migration = Aws::Record::TableMigration.new(Contact)
    migration.create!(
      provisioned_throughput: {
        read_capacity_units: 1,
        write_capacity_units: 1
      }
    )
    migration.wait_until_available
  end

  def down
    migration = Aws::Record::TableMigration.new(Contact)
    migration.delete!
  end
end

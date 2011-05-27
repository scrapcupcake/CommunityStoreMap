class StoreNewRecords < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.string :hours
      t.string :phone_number
      t.string :email
    end
  end

  def self.down
    change_table :stores do |t|
      t.remove :hours
      t.remove :phone_number
      t.remove :email
    end
  end
end

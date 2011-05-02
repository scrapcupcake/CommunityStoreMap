class StoresAddAddress < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.string :address
    end
  end

  def self.down
    change_table :stores do |t|
      t.remove :address
    end
  end
end

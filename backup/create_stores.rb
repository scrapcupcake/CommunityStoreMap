class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.float :lat
      t.float :lng
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end

class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name
      t.string :url
      t.text :description
      t.decimal :lat, { :scale => 7, :precision => 12 }
      t.decimal :lng, { :scale => 7, :precision => 12 }

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end

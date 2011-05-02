class CreateStoreLocs < ActiveRecord::Migration
  def self.up
    create_table :store_locs do |t|
      t.float :lat
      t.float :lng
      t.string :name
      t.string :icon
      t.timestamps
    end
  end

  def self.down
    drop_table :store_locs
  end
end

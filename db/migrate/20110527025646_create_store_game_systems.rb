class CreateStoreGameSystems < ActiveRecord::Migration
  def self.up
    create_table :store_game_systems, :id => false do |t|
      t.references :store, :game_system
    end
  end

  def self.down
    drop_table :store_game_systems
  end
end

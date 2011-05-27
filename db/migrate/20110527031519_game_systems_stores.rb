class GameSystemsStores < ActiveRecord::Migration
  def self.up
    drop_table :store_game_systems #destrucive edit, intentional
    create_table :game_systems_stores, :id => false do |t|
      t.references :store, :game_system
    end
  end

  def self.down
    drop_table :game_systems_stores
  end
end

class CreateGameSystems < ActiveRecord::Migration
  def self.up
    create_table :game_systems do |t|
      t.string :name
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :game_systems
  end
end

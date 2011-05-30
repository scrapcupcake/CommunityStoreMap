class StoresAddStateCountryOnlineStoreUrl < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.string :state
      t.string :country
      t.string :online_store_url
    end
  end

  def self.down
    change_table :stores do |t|
      t.remove :state
      t.remove :country
      t.remove :online_store_url
    end
  end
end

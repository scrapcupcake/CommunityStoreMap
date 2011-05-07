class StoresAddApproval < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.boolean :approved, :default => false 
    end
  end

  def self.down
    change_table :stores do |t|
      t.remove :approved
    end
  end
end

class ChangeDefaultForApproved < ActiveRecord::Migration
  def self.up
    change_column_default(:stores, :approved, false)
  end

  def self.down
  end
end

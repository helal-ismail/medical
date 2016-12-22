class AddStateToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :state, :integer, :default => 0
  end
end

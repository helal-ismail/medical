class AddEntityIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :entity_id, :int
    add_column :notifications, :entity_type, :string
  end
end

class AddDescriptionArToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :description_ar, :string
    rename_column :notifications, :description, :description_en
  end
end

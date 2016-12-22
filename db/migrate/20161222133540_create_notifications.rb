class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text :title
      t.text :description
      t.string :icon_url

      t.timestamps null: false
    end
  end
end

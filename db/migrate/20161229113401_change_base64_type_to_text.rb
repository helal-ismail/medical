class ChangeBase64TypeToText < ActiveRecord::Migration
  def change
    change_column :users, :img_base64, :text
  end
end

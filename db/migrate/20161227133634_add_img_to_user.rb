class AddImgToUser < ActiveRecord::Migration
  def up
    add_column :users, :img_url, :string
    add_column :users, :img_base64, :string
  end
  
  def down
    remove_column :users, :img_url
    remove_column :users, :img_base64
  end
end

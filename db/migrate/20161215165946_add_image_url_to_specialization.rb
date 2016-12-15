class AddImageUrlToSpecialization < ActiveRecord::Migration
  def change
    add_column :specializations, :image_url, :string, :default => ""
  end
end

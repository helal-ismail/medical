class AddImageUrlToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :image_url, :string, :default=>""
  end
end

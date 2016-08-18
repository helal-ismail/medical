class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :address
      t.string :latitude
      t.string :longitude
      t.string :phone
      t.string :website
      t.string :email
      
      t.timestamps null: false
    end
  end
end

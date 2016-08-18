class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.integer :hospital_id
      t.integer :specialization_id
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

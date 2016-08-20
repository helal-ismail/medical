class CreateDoctorPrices < ActiveRecord::Migration
  def change
    create_table :doctor_prices do |t|
      t.integer :doctor_id
      t.integer :clinic_id
      t.double :price
      t.timestamps null: false
    end
  end
end

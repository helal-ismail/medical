class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :uid
      t.float :discount
      t.float :price
      t.date :appointment_date
      t.time :appointment_time
      t.integer :counter
      t.integer :state
      t.text :notes
      t.integer :doctor_price_id
      t.integer :patient_id
      t.timestamps null: false
    end
  end
end

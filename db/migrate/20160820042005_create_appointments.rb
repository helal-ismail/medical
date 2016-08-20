class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.double :discount
      t.double :price
      t.date :appointment_date
      t.time :appointment_time
      t.integer :counter
      t.integer :state
      t.text :notes
      t.timestamps null: false
    end
  end
end

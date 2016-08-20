class CreateDailySchedules < ActiveRecord::Migration
  def change
    create_table :daily_schedules do |t|
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time
      t.integer :doctor_price_id
      t.timestamps null: false
    end
  end
end

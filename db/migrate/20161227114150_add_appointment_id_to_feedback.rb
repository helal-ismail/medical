class AddAppointmentIdToFeedback < ActiveRecord::Migration
  def up
    add_column :feedbacks, :appointment_id, :integer
  end
  
  def down
    remove_column :feedbacks, :appointment_id
  end
end

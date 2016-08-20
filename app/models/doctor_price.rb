class DoctorPrice < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
  has_many :doctor_price
end

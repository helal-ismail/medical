class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor_prices
#  belongs_to :doctor, :through => :doctor_prices
#  belongs_to :clinic, :through => :doctor_prices
  
end

class Doctor < User
  has_many :clinics, :through => :doctor_prices
  has_many :appointments, :through => :doctor_prices
end

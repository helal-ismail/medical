class Doctor < User
  has_and_belongs_to_many :clinics, :through => :doctor_prices
  has_many :appointments, :through => :doctor_prices
end

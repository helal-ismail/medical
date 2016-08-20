class Clinic < ActiveRecord::Base
  has_and_belongs_to_many :doctors, :through => :doctor_prices
  belongs_to :hospital
  belongs_to :specialization
  has_many :appointments, :through => :doctor_prices

end

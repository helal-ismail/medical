class Clinic < ActiveRecord::Base
  has_many :doctors, :through => :doctor_prices
  belongs_to :hospital
  belongs_to :specialization
  has_many :appointments, :through => :doctor_prices
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode          # auto-fetch coordinates

end

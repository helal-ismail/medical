class Hospital < ActiveRecord::Base
  has_many :clinics
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
end

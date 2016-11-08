class Hospital < ActiveRecord::Base
  has_many :clinics
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode          # auto-fetch coordinates
  
  
  def self.search(lat,lng, limit)
    result = []
    if limit < 0
      result = Hospital.near([lat, lng])
    else
      result = Hospital.near([lat, lng], limit)
    end
    return result
  end
  
end

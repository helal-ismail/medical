class Hospital < ActiveRecord::Base
  has_many :clinics
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode          # auto-fetch coordinates
  
  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%")
    end
  end
  
  def self.search(lat,lng, limit)
    result = []
    if limit < 0
      result = Hospital.near([lat, lng])
    else
      result = Hospital.near([lat, lng], limit)
    end
    return result
  end
  
  def as_json(options)
    super(:only=>[:id, :name, :address, :latitude, :longitude, :phone, :website, :email ])
  end
  
end

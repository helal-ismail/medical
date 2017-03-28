class Clinic < ActiveRecord::Base

  belongs_to :hospital
  belongs_to :specialization
  has_many :doctor_prices
  has_many :appointments, :through => :doctor_prices
  has_many :doctors, :through => :doctor_prices
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode          # auto-fetch coordinates


  def self.private_clinics
    Clinic.where(:hospital_id => 0)
  end

  def appointments_by_period(period_start, period_end)
    date_start = Date.parse(period_start)
    date_end = Date.parse(period_end)
    result = []
    total = 0
    while (date_start < date_end)
      appointments_count = self.appointments_by_date(date_start).count
      total = total + appointments_count
      record = {:date => date_start , :count => appointments_count}
      result << record
      date_start = date_start+1
    end
    {:clinic_id =>self.id, :clinic_name => self.name, :specialization => self.specialization.name , :total => total, :data => result}
#    self.appointments.where("appointment_date between ? AND ?", period_start, periond_end)

  end


  def appointments_by_date(date)
    self.appointments.where(:appointment_date => date)
  end



  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      private_clinics
    else
      private_clinics.where('name LIKE ?', "%#{pattern}%")
    end
  end

  def as_json(options)
    # super(:only=>[:id, :uid, :name, :address ])
    hospital = self.hospital
    result = {:id => self.id, :name => self.name, :address => self.address,
              :specialization => self.specialization, :address=> self.address||'',
              :latitude=> self.latitude||'', :longitude=>self.longitude||'', :hospital => hospital.name || '', :image_url=> hospital.image_url || ''}
  end


end

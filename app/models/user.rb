class User < ActiveRecord::Base

  has_many :feedbacks

  enum gender: [ :male, :female ]
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user.present?
      encrypted_password = Digest::SHA256.hexdigest(password + user.salt)
      if encrypted_password == user.encrypted_password
        return {:success => true, :user => user, :status => 200 }
      else
        return {:success => false, :msg => "Incorrect password", :status => 500}
      end
    else
      return {:success => false, :msg => "Email not found", :status => 400}
    end
  end

  def edit_field(key, value)
    self["#{key}"] = value
    self.save
  end



  def as_json(options)
    super(:only => [:id, :name, :email, :phone, :access_token, :channel, :gender, :address, :type])
  end
end

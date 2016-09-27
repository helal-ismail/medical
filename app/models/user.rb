class User < ActiveRecord::Base
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

end

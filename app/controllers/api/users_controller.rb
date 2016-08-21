class Api::UsersController < ApiController
  

  api :POST, '/user', "User Registration"
  def register
    user_params = params[:user]
    password = user_params[:password] || ''
    user = User.new
    user.name = user_params[:name]
    user.username = user_params[:username]
    user.email = user_params[:email]
    user.password_salt = SecureRandom.hex(4)
    user.encrypted_password = Digest::SHA256.hexdigest(password + user.password_salt)
    access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + user.password_salt)
    user.access_token = access_token[0..30]
    user.channel = "c"+ access_token[0..10]
    
    uid = Digest::SHA256.hexdigest(DateTime.now.to_s + user.password_salt)
    user.uid = uid[0..10]
    
    if user.save
      render :json => {:success => true, :user => user}

    else
      render :json => {:success =>false, :msg => "Username or Email already exists"}
    end
  end

  api :POST, '/user/login', "User Login"
  def login
    
  end
  
  api :POST, '/user/edit', "Update User Profile"
  def edit_profile
    
  end
  
  api :get, '/user/profile', "Get User Profile"
  def get_profile
    
  end
end

class Api::UsersController < ApiController

  api :POST, '/user', "User Registration"

  param :user, Hash, :desc => "User Hash / JSONObject", :required => true do

    param :email, String, :desc => "Email", :required => true
    param :password, String, :desc => "Password", :required => true
    param :username, String, :desc => "Username / for Social Login / Future work", :required => false
    param :type, String, :desc => "[doctor/admin/patient]", :required => true
    param :name, String, :desc => "Name", :required => false
    param :phone, String, :desc => "Phone", :required => true
    param :address, String, :desc => "Address", :required => true
    param :gender, String, :desc => "Gender [male/female]", :required => true

  end

  def social_login
    user_params = params[:user]
    user = User.find_by_username(user_params[:username])
    if user.present?
      render :json => {:user => user} and return
    end

    user = User.new
    user.name = user_params[:name]
    user.username = user_params[:username]
    user.email = user_params[:email]
    user.type = user_params[:type]
    user.phone = user_params[:phone]
    user.address = user_params[:address]
    user.gender = user_params[:gender]
    password = ''
    user.salt = SecureRandom.hex(4)
    user.encrypted_password = Digest::SHA256.hexdigest(password + user.salt)
    access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + user.salt)
    user.access_token = access_token[0..30]
    user.channel = "c"+ access_token[0..10]

    uid = Digest::SHA256.hexdigest(DateTime.now.to_s + user.salt)
    user.uid = uid[0..10]
    user.register_device(params[:device])

    if user.save
      render :json => {:user => user}
    else
      render :json => {:msg => "Error while trying to save user"}, :status => 500
    end
  end

  def register

    user_params = params[:user]
    validation = validate_new_user(user_params)
    if (!validation[:is_valid])
      render :json => {:message => validation[:message]}, :status => 500 and return
    end
    user = nil

    password = user_params[:password] || ''
    user = User.new
    user.name = user_params[:name]
    user.username = user_params[:username]
    user.email = user_params[:email]
    user.type = user_params[:type]
    user.phone = user_params[:phone]
    user.address = user_params[:address]
    user.gender = user_params[:gender]

    user.salt = SecureRandom.hex(4)
    user.encrypted_password = Digest::SHA256.hexdigest(password + user.salt)
    access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + user.salt)
    user.access_token = access_token[0..30]
    user.channel = "c"+ access_token[0..10]

    uid = Digest::SHA256.hexdigest(DateTime.now.to_s + user.salt)
    user.uid = uid[0..10]
    
    user.register_device(params[:device])

    if user.save
      render :json => {:user => user}

    else
      render :json => {:msg => "Username or Email already exists"}
    end

  end

  api :POST, '/users/login', "User Login"
  param :email, String, :desc => "Email", :required => true
  param :password, String, :desc => "Password", :required => true

  def login
    response = User.authenticate(params[:email], params[:password])
    render :json=> response.except(:status), :status=> response[:status]
  end

  api :POST, '/user/edit', "Update User Profile"

  def edit_profile

  end

  api :get, '/user/profile', "Get User Profile"
  param :id, String, :desc => "user's UID", :required => true

  def get_profile
    user = User.find_by_uid(params["uid"])
    if user.present?
      render :json => {:data => user}
    else
      render :json => {:msg => "User not found"}, :status => 400
    end
  end

  def edit
    user = User.find(params[:user_id])
    if !user.present?
      render :json => {:msg => "User not found"}, :status => 400 and return
    end
    
    if params[:name].present?
      user.edit_field("name",params[:name])
    end
    
    if params[:phone].present?
      user.edit_field("phone",params[:phone])
    end
    
    render :json => {:msg => "Fields have been updated", :data => user}
    

  end

  def change_password

    new_password = params[:new_password]
    old_password = params[:old_password]

    user = User.find(params[:user_id])
    if !user.present?
      render :json => {:msg => "User not found"}, :status => 400 and return
    end
    old_encrypted_password = Digest::SHA256.hexdigest(old_password + user.salt)
    if (old_encrypted_password != user.encrypted_password)
      render :json => {:msg => "Incorrect old password"}, :status => 500 and return
    end

    user.encrypted_password = Digest::SHA256.hexdigest(new_password + user.salt)
    access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + user.salt)
    user.access_token = access_token[0..30]
    user.save
    render :json => {:msg => "Password has been changed"}

  end

  private

  def validate_new_user(user_params)
    result = {:is_valid=>true, :message=>"User credentials are valid"}

    # Check if the email exists
    user = User.find_by_email(user_params[:email])
    if user.present?
      result[:is_valid] = false
      result[:message] = "Email already exists"
    end

    if !["Doctor","Patient"].include? user_params[:type]
      result[:is_valid] = false
      result[:message] = "Invalid User Type"
    end

    return result

  end
end

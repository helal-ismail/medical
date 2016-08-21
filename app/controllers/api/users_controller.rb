class Api::UsersController < ApiController
  
    # Media Upload Callback
  api :POST, '/user', "User Registration"
  def register
    
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

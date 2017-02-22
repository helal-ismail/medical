class Web::SessionController < WebController
  skip_before_filter :handleSessionSecurity

  layout 'web/login'
  def login
    if isLoggedIn
      redirect_user
    end
  end

  def login_submit
    email = params[:email]
    password = params[:password]
    response = User.authenticate(email, password)
    if response[:success]
#      session[:id] = response[:user][:id]
#      session[:access_token] = response[:user][:access_token]
      set_session_user(response[:user])
      redirect_user
    else
      flash[:notice] = "Invalid Email or Password"
      render :action => 'login'
    end
  end

  def set_session_user(user)
    session[:user] = user
    session[:id] = user.id
    session[:access_token] = user.access_token
  end

  def redirect_user
    case session[:user]["type"]
    when "SuperAdmin"
      redirect_to "/dashboard"
    else
      user = User.find(session[:id])
      redirect_to "/hospitals/" + user.hospital.id.to_s
    end
  end

  def logout
    flash[:notice] = "Logged Out"
    session.clear
    redirect_to "/dashboard"
  end



end

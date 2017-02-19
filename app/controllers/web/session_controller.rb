class Web::SessionController < WebController
  skip_before_filter :handleSessionSecurity
  #layout 'web/login'

  def login_submit
    email = params[:session][:email]
    password = params[:session][:password]
    response = User.authenticate(email, password)
    if response[:success]
      session[:uid] = response[:user][:uid]
      session[:access_token] = response[:user][:access_token]
      redirect_to "/home"
    else
      flash[:notice] = "Invalid Email or Password"
      render :action => 'login'
    end
  end

  def logout
    flash[:notice] = "Logged Out"
    session.clear
    redirect_to "/login"
  end



end

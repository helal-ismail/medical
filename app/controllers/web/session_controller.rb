class Web::SessionController < WebController
  skip_before_filter :handleSessionSecurity

  layout 'web/login'
  def login
    if isLoggedIn
      redirect_to "/dashboard" and return
    end
  end

  def login_submit
    email = params[:email]
    puts email
    puts "============"
    puts params
    puts "====="
    password = params[:password]
    response = User.authenticate(email, password)
    if response[:success]
      session[:id] = response[:user][:id]
      session[:access_token] = response[:user][:access_token]
      redirect_to "/dashboard"
    else
      flash[:notice] = "Invalid Email or Password"
      render :action => 'login'
    end
  end

  def logout
    flash[:notice] = "Logged Out"
    session.clear
    redirect_to "/dashboard"
  end



end

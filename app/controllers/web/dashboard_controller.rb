class Web::DashboardController < WebController
  layout 'web/dashboard'
  skip_before_filter :handleSessionSecurity

  def hello

  end

  def hend

  end

  def raptors
    redirect_to "https://www.facebook.com/Raptors-245634579176430"
  end
end

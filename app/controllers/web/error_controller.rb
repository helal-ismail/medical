class Web::ErrorController < WebController
  skip_before_filter :handleSessionSecurity

end

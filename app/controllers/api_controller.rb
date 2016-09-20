class ApiController < ApplicationController
  
  rescue_from ActionController::Excepton, :with => :handle_exception

  def handle_exception(exception)
    render :json => {:success=>false, :msg=>exception.message }, :status => 500
  end

end

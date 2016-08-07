class TouchController < ApplicationController
  def touch
    render :json => {:success => true, :msg => "Server Online", :timestamp => "#{DateTime.now}"}
  end
end

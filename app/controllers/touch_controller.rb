class TouchController < ApplicationController
  def touch
    begin
    render :json => {:success => true, :msg => "Server Online", :timestamp => "#{DateTime.now}"}
    rescue Exception => e
      render :json => {:success => false, :msg => "#{e.message}"}
    end
      
  end
end

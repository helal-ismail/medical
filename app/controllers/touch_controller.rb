class TouchController < ApplicationController
  def touch
    begin
    render :json => {:success => true, :msg => "Server Online", :timestamp => "#{DateTime.now}", :url => root_url}
    rescue Exception => e
      render :json => {:success => false, :msg => "#{e.message}"}
    end
      
  end
end

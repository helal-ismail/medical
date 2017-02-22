 class Api::InsuranceCosController < ApiController


  def profile
    insuranceCompany = InsuranceCompany.find_by_id(params[:id])
    if insuranceCompany.present?
      render :json => {:data => insuranceCompany}
    else
      render :json => {:msg => "ID not found"}, :status => 400
    end
  end


  def new
    if params[:insurance_co_id].to_i > 0
      insuranceCompany = InsuranceCompany.find(params[:insurance_co_id])
      insuranceCompany.update(name: params[:name], website: params[:website], address: params[:address])
    else
      insuranceCompany = InsuranceCompany.create(name: params[:name], website: params[:website], address: params[:address])
    end
    render :json => {:data => insuranceCompany}
  end

end

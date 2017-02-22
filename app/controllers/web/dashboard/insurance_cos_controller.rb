class Web::Dashboard::InsuranceCosController < Web::DashboardController

  def index
    @insurance_cos = InsuranceCompany.all
  end

  def new
    @insurance_co_id = 0
  end

  def edit
    @insurance_co_id = params[:id]
    render :file => "web/dashboard/insurance_cos/new"
  end


end

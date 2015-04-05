Bizevo::App.controllers :quotn do

  get :index, :with => :month do
    @quotn = Quotation.current_month(params[:month]).joins(:project, :csc_cust).includes(:project, :csc_cust).order(:main_group_mst_blg_cd, :pcu_cd, :quotn_no)
    render 'quotn/index'
  end

  get :index, :map => 'quotn/:month/:blg_cd' do
    @quotn = Quotation.current_month(params[:month]).joins(:project, :csc_cust).includes(:project, :csc_cust).where(:main_group_mst_blg_cd => params[:blg_cd])
    render 'quotn/index'
  end
end

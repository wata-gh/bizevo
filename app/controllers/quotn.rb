Bizevo::App.controllers :quotn do

  get :index do
    @quotn = Quotation
      .filter(params)
      .references(:pcdc_contract, :maint_contract, :bulk_contract)
      .joins(:sales_assoc, :updater, :belonging, :csc_cust)
      .includes(:sales_assoc, :updater, :pcdc_contract, :maint_contract, :bulk_contract, :belonging, :csc_cust)
      .order(:final_upd_date => :desc, :quotn_no => :desc, :quotn_ver_no => :desc).per(10)
    render 'quotn/home'
  end

  get :index, :with => :month do
    @quotn = Quotation.current_month(params[:month]).where :main_group_mst_blg_cd => Belonging.business_blg.pluck(:mst_blg_cd)
    render 'quotn/index'
  end

  get :index, :map => 'quotn/:month/:blg_cd' do
    @quotn = Quotation.current_month(params[:month]).where(:main_group_mst_blg_cd => params[:blg_cd])
    render 'quotn/index'
  end

  get :detail, :map => 'quotn/detail/:quotn_no/:quotn_ver_no' do
    @quotns = Quotation
      .references(:pcdc_contract, :maint_contract, :bulk_contract)
      .joins(:sales_assoc, :updater, :belonging, :csc_cust)
      .includes(:sales_assoc, :updater, :pcdc_contract, :maint_contract, :bulk_contract, :belonging, :csc_cust)
      .where(:quotn_no => params[:quotn_no]).order(:quotn_ver_no => :desc)
    @quotn = @quotns.find {|q| q.quotn_ver_no == params[:quotn_ver_no].to_i}
    halt 404 unless @quotn
    @reports = ProjectReport.where(:quotn_no => @quotn.quotn_no).order(:created_at => :desc).page(params[:page]).per(5)
    render 'quotn/detail'
  end

  get :detail, :map => 'quotn/assign/:quotn_no/:quotn_ver_no' do
    @quotn = Quotation.find_by :quotn_no => params[:quotn_no], :quotn_ver_no => params[:quotn_ver_no]
    halt 404 unless @quotn
    @reports = ProjectReport.where(:quotn_no => @quotn.quotn_no).order(:created_at => :desc).page(params[:page]).per(5)
    render 'quotn/detail'
  end

  get :report, :map => 'quotn/detail/:quotn_no/:quotn_ver_no/report' do
    @quotn = Quotation.find_by :quotn_no => params[:quotn_no], :quotn_ver_no => params[:quotn_ver_no]
    halt 404 unless @quotn
    @reports = ProjectReport.where(:quotn_no => @quotn.quotn_no).order(:created_at => :desc).page(params[:page]).per(5)
    render 'quotn/report', :layout => false
  end

  get :report, :map => 'quotn/detail/:quotn_no/:quotn_ver_no/log' do
    @quotn = Quotation.find_by :quotn_no => params[:quotn_no], :quotn_ver_no => params[:quotn_ver_no]
    halt 404 unless @quotn
    'この課題に関する作業ログはまだありません。'
  end
end

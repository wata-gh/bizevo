Bizevo::App.controllers :dashboard do

  get :index do
    redirect "/dashboard/#{current_user.user.mst_blg_cd.strip[0, 8]}/#{Date.today.strftime('%Y%m')}"
  end

  get :index, :map => '/dashboard/:mst_blg_cd/:month' do
    s = Date.parse "#{params[:month]}01"
    e = s.at_end_of_month
    range = s..e
    calc_dashboard_data range, params[:mst_blg_cd]
    @quotn = Quotation.detail
      .where(:main_group_mst_blg_cd => params[:mst_blg_cd])
      .order(:final_upd_date => :desc, :quotn_no => :desc, :quotn_ver_no => :desc)
      .page(params[:page])
      .per(5)
    render 'dashboard/index'
  end

end

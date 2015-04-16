Bizevo::App.controllers 'api/quotn' do

  get :assign, :map => 'api/quotn/assign/:quotn_no/:quotn_ver_no' do
    assign = AssignPmbr.where(:quotn_no => params[:quotn_no], :quotn_ver_no => params[:quotn_ver_no]) #.order(:assign_pmh => {:setup_date_ym => :asc, :asgn_no => :asc})
    res = assign.map do |a|
      d = {
        :asgn_no           => a.asgn_no,
        :personal          => {
          :nm       => a.personal.nm,
          :psnal_cd => a.personal.psnal_cd,
        },
        :role_nm           => a.role.role_nm,
        :total_man_hour_mm => 0.0,
        :assign_start      => a.asgn_start_date.format_ymd,
        :assign_end        => a.asgn_end_date.format_ymd,
      }
      t = 0.0
      a.assign_pmh.each do |h|
        d[h.setup_date_ym] = h.man_hour_mm
        t += h.man_hour_mm
      end
      d[:total_man_hour_mm] = t
      d
    end
    suc_res res
  end

  post :assign, :map => 'api/quotn/assign/:quotn_no/:quotn_ver_no' do
    pmbr = AssignPmbr.where(
      :quotn_no => params[:quotn_no],
      :quotn_ver_no => params[:quotn_ver_no],
      :mbr_psnal_cd => params[:psnal_cd],
    ).first_or_initialize
    pmbr.role_cd = params[:role_cd]
    pmbr.reprst_flg = 0 # 固定
    pmbr.asgn_start_date = Date.strptime(params[:start_date], '%Y-%m-%d').strftime('%Y%m%d')
    pmbr.asgn_end_date = Date.strptime(params[:end_date], '%Y-%m-%d').strftime('%Y%m%d')
    if pmbr.new_record?
      max = AssignPmbr.where(
        :quotn_no => params[:quotn_no],
        :quotn_ver_no => params[:quotn_ver_no],
      ).maximum(:asgn_no)
      pmbr.asgn_no = max.present? ? max + 1 : 1
    end
    return err_res pmbr.errors unless pmbr.save
    suc_res pmbr
  end

  post :assign_mh, :map => 'api/quotn/assign_mh/:quotn_no/:quotn_ver_no' do
    q = Quotation.find_by :quotn_no => params[:quotn_no], :quotn_ver_no => params[:quotn_ver_no]
    return err_res 'not found' unless q
    mh = AssignPmh.where(
      :quotn_no => params[:quotn_no],
      :quotn_ver_no => params[:quotn_ver_no],
      :asgn_no => params[:asgn_no],
      :setup_date_ym => params[:setup_date_ym]
    ).first_or_initialize
    mh.man_hour_mm = params[:man_hour_mm]
    return err_res mh.errors unless mh.save
    suc_res mh
  end
end

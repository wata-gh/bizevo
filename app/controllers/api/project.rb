Bizevo::App.controllers 'api/project' do

  get :assign, :map => 'api/project/assign/:prj_cd' do
    assign = ProjectAssign.where(:prj_cd => params[:prj_cd])
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
      a.project_assign_mh.each do |h|
        d[h.setup_date_ym] = h.man_hour_mm
        t += h.man_hour_mm
      end
      d[:total_man_hour_mm] = t
      d
    end
    suc_res res
  end

  delete :assign, :map => 'api/project/assign/:prj_cd' do
    assign = ProjectAssign.find_by :prj_cd=> params[:prj_cd], :asgn_psnal_cd => params[:psnal_cd], :asgn_no => params[:asgn_no]
    halt 404 unless assign
    error assign.errors unless assign.destroy
    suc_res assign
  end

  post :assign, :map => 'api/project/assign/:prj_cd' do
    pa = ProjectAssign.where(
      :prj_cd        => params[:prj_cd],
      :asgn_psnal_cd => params[:psnal_cd],
    ).first_or_initialize
    pa.role_cd = params[:role_cd]
    pa.asgn_start_date = Date.strptime(params[:start_date], '%Y-%m-%d').strftime('%Y%m%d')
    pa.asgn_end_date = Date.strptime(params[:end_date], '%Y-%m-%d').strftime('%Y%m%d')
    if pa.new_record?
      max = ProjectAssign.where(
        :prj_cd        => params[:prj_cd],
      ).maximum(:asgn_no) + 1
       pa.asgn_no = max.present? ? max + 1 : 1
    end
    return err_res pa.errors unless pa.save
    suc_res pa
  end

  post :assign_mh, :map => 'api/project/assign_mh/:prj_cd' do
    prj = Project.find_by :prj_cd => params[:prj_cd]
    err_res 'no project' unless prj
    mh = ProjectAssignMh.where(
      :prj_cd        => params[:prj_cd],
      :asgn_no       => params[:asgn_no],
      :setup_date_ym => params[:setup_date_ym]
    ).first_or_initialize
    mh.man_hour_mm = params[:man_hour_mm]
    return err_res mh.errors unless mh.save
    suc_res mh
  end

  post :report, :with => :quotn_no do
    rep = ProjectReport.new({
      :report          => params[:report],
      :report_psnal_cd => '202045',
      :quotn_no        => params[:quotn_no],
    })
    return err_res unless rep.save
    suc_res
  end
end

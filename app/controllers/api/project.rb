Bizevo::App.controllers 'api/project' do

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

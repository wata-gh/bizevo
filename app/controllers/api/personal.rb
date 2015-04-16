Bizevo::App.controllers 'api/personal' do

  get :search  do
    q = "%#{params[:query]}%"
    people = Personal.where(:resign_fin_flg => 0).where('NM like ? or PSNAL_cd like ?', q, "#{params[:query]}%").pluck(:nm)
    suc_res people
  end

end

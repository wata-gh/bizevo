Bizevo::App.controllers :ord do

  get :index, :map => 'ord/:estimate_no/:estimate_branch_no' do
    @ord = Libra::Ord.find_by :estimate_no => params[:estimate_no], :estimate_branch_no => params[:estimate_branch_no]
    halt 404 unless @ord
    render 'ord/detail'
  end

  get :index do
    'ord'
  end

end

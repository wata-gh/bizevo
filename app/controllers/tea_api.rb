Bizevo::App.controllers 'tea/api' do
  get :user, with: :id  do
    suc_res id: params[:id]
  end
end

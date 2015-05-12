Bizevo::App.controllers :kiita_api do

  get :tags do
    suc_res :tags => Tag.all.pluch(:tag)
  end

  get :increment_like, :with => :id do
    a = increment_like params[:id]
    suc_res :like => a.likes if a
  end

end

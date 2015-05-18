Bizevo::App.controllers :kiita_api do

  get :tags do
    suc_res :tags => Tag.all.pluch(:tag)
  end

  get :increment_like, :with => :id do
    a = increment_like params[:id]
    if a
      suc_res :likes => a.likes
    else
      err_res
    end
  end

end

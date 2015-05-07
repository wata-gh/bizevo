Bizevo::App.controllers :kiita_api do

  get :tags do
    suc_res :tags => Tag.all.pluch(:tag)
  end

end

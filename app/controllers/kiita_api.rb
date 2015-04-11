Bizevo::App.controllers :kiita_api do

  get :tags do
    suc_res :tags => Tag.all.map(&:tag)
  end

end

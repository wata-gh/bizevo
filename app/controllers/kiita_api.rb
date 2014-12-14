Bizevo::App.controllers :kiita_api do

  get :tags do
    @tags = Tag.all
    output @tags.map &:tag
  end

end

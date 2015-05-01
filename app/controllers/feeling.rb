Bizevo::App.controllers :feeling do

  get :index do
    render 'feeling/index'
  end

  get :index, :with => :id do
    @feeling = Redmine::Feeling.references(:comments).includes(:comments).find params[:id]
    halt 404 unless @feeling
    render 'feeling/detail'
  end
end

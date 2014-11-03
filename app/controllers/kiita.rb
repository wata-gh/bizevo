Bizevo::App.controllers :kiita do

  get :index do
    @articles = Article.joins(:article_tags).includes(:article_tags).all
    render 'kiita/index'
  end

  get :new do
    render 'kiita/new'
  end

  get :update, :with => :id do
    @article = Article.joins(:article_tags).includes(:article_tags).find_by_id(params[:id])
    halt 404 unless @article
    render 'kiita/update'
  end

  post :update do
    update_article params
    redirect '/kiita/'
  end

  get :view, :with => :id do
    @article = Article.find_by_id params[:id]
    halt 404 unless @article
    @md_text = mark_down_parse @article.article
    render 'kiita/view'
  end

  post :create do
    save_article params
    redirect '/kiita/'
  end

  # error 404 do
  #   render 'errors/404'
  # end
end

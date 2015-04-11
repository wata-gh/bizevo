Bizevo::App.controllers :kiita do
  layout :kiita_layouts

  get :index do
    @title = 'kiita | top'
    @articles = Article.joins(:article_tags).includes(:article_tags).page params[:page]
    render 'kiita/index'
  end

  get :new do
    @title = 'kiita | memo'
    render 'kiita/new'
  end

  post :create do
    begin
      save_article params
    rescue => e
      flash.now[:error] = e.message
      return render 'kiita/new'
    end
    flash[:success] = 'Post was successfully created.'
    redirect url(:kiita, :index)
  end

  get :update, :with => :id do
    @title = 'kiita | edit'
    @article = Article.joins(:article_tags).includes(:article_tags).find_by_id(params[:id])
    halt 404 unless @article
    render 'kiita/update'
  end

  post :update do
    begin
      ActiveRecord::Base.transaction do
        update_article params
        # 新規タグのinsert、削除タグの delete を行う
        save_new_tag params[:article_tag][:tag]
        update_article_tag params
      end
    rescue => e
      flash[:error] = e.message
      redirect "kiita/update/#{params[:article][:id]}"
    end
    flash[:success] = 'Post was successfully update.'
    redirect url(:kiita, :index)
  end

  get :view, :with => :id do
    @title = 'kiita | view'
    @article = Article.find_by_id params[:id]
    halt 404 unless @article
    @md_text = mark_down_parse @article.article
    render 'kiita/view'
  end

  delete :destroy, :with => :id do
    @article = Article.find params[:id]
    halt 404 unless @article
    begin
      destroy_article @article
    rescue => e
      p e
      # そんなものは存在しない
      halt 404
    end
    redirect url(:kiita, :index)
  end
end

Bizevo::App.controllers :kiita do
  layout :kiita_layouts

  get :index do
    @title = 'kiita | top'
    @articles = Article.eager_load(:article_tags).includes(:article_tags)
                  .order('articles.created_at DESC').page params[:page]
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
    @article = Article.eager_load(:article_tags).includes(:article_tags).find_by :id => params[:id]
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
      p e
      flash[:error] = e.message
      redirect "kiita/update/#{params[:article][:id]}"
    end
    flash[:success] = 'Post was successfully update.'
    redirect url(:kiita, :index)
  end

  get :view, :with => :id do
    @title = 'kiita | view'
    @article = Article.find_by :id => params[:id]
    halt 404 unless @article
    @user = User.find_by :id => @article.user_id
    halt 404 unless @user
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

  get :mypage do
    @title = 'my page'
    @user = current_user
    @articles = Article.eager_load(:article_tags).includes(:article_tags).where("user_id = ?", @user.id)
                  .order 'articles.created_at DESC'
    render 'kiita/mypage'
  end

  get :edit_profile do
    @tile = 'edit profile'
    render 'kiita/edit_profile'
  end

  post :edit_profile do
    user = User.find_by :name => current_user.sAMAccountName
    user.s3_upload params['user']['profile_icon'][:tempfile] if params['user']['profile_icon']
    user.icon_path = user.upload_file_name
    if user.save!
      @tile = 'my page'
      redirect url(:kiita, :mypage)
    end
    @title = 'edit profile'
    render 'kiita/edit_profile'
  end

  get :tag, :with => :tag do
    @title = "#{params[:tag]}ページ"
    @articles = Article.eager_load(:article_tags).includes(:article_tags).where("tag = ?", params[:tag]).page params[:page]
    render 'kiita/tag'
  end

end

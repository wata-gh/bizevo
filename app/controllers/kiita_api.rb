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

  get :comments, :with => :id do
    ac = ArticleComment.includes(:user)
      .joins(:user)
      .where :article_id => params[:id]
    return err_res if ac.blank?
    comments_data = ac.map do |a|
      {
        :id => a.id,
        :name => a.user.name,
        :comment => a.comment,
        :image => a.user.get_thumbnail_path,
        :time_ago => time_ago_in_words(a.created_at),
      }
    end
    suc_res :data => comments_data
  end

  post :comments, :with => :id do
    ac = ArticleComment.new {|m|
      m.article_id = params[:id].to_i
      m.user_id = current_user.id
      m.comment = params['comment']
    }
    return err_res unless ac.save
    suc_res
  end
end

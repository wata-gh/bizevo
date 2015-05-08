Bizevo::App.controllers :feeling do

  get :index do
    ru = current_user.redmine_user
    @feelings = Redmine::Feeling.where('at >= ? AND user_id = ?', Date.today - 6, ru.id).pluck :at
    render 'feeling/index'
  end

  get :index, :with => :id do
    if request.env['HTTP_X_REMOTE'] == 'true'
      ru = current_user.redmine_user
      @feeling = Redmine::Feeling.where(:at => params[:id], :user_id => ru.id).first_or_initialize
      return render 'feeling/_feeling', :layout => false
    end
    @feeling = Redmine::Feeling.references(:comments).includes(:comments).order('comments.created_on').find_by :id => params[:id]
    halt 404 unless @feeling
    render 'feeling/detail'
  end
end

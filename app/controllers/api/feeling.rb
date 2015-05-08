Bizevo::App.controllers 'api/feeling' do

  get :bind do
    f = Redmine::Feeling.references(:user).includes(:user).order(:id => :desc).page(params[:page])
    if params[:project_id]
      ids = Redmine::Member.where(:project_id => params[:project_id]).pluck :user_id
      f = f.where :user_id => ids
    end
    f = f.where('feelings.id > ?', params[:id]) if params[:id].present?
    f = f.where(:user_id => params[:user_id]) if params[:user_id].present?
    f.each {|d| d.me = current_user.redmine_user.id}
    suc_res f.map(&:to_jsondata)
  end

  get :more do
    f = Redmine::Feeling.joins(:user).includes(:user).order(:id => :desc).page(params[:page])
    if params[:project_id]
      ids = Redmine::Member.where(:project_id => params[:project_id]).pluck :user_id
      f = f.where :user_id => ids
    end
    f = f.where('feelings.id > ?', params[:id]) if params[:id].present?
    f = f.where('feelings.id < ?', params[:last_id]) if params[:last_id].present?
    f = f.where(:user_id => params[:user_id]) if params[:user_id].present?
    f.each {|d| d.me = current_user.redmine_user.id}
    suc_res f.map(&:to_jsondata)
  end

  post :wiki do
    f = Redmine::Feeling.new
    f.description = params[:v].gsub /\n/, "\r\n"
    suc_res :html => f.description_disp_html
  end

  post :index, :with => :at do
    ru = current_user.redmine_user
    f = Redmine::Feeling.where(:at => params[:at], :user_id => ru.id).first_or_initialize
    f.description = params[:description].gsub /\n/, "\r\n"
    f.level = params[:level]
    f.save
    suc_res f.as_json
  end

  delete :index, :with => :id do
    ru = current_user.redmine_user
    f = Redmine::Feeling.find_by :id => params[:id], :user_id => ru.id
    halt 404 unless f
    f.destroy
    suc_res f.as_json
  end

  post :comment, :map => 'api/feeling/:id/comment' do
    f = Redmine::Feeling.find_by :id => params[:id]
    halt 404 unless f

    begin
      ActiveRecord::Base.transaction do
        c = f.comments.build({
            :commented_id   => f.id,
            :commented_type => 'Feeling',
            :comments       => params[:comments],
            :author_id      => current_user.redmine_user.id,
            :created_on     => DateTime.now,
            :updated_on     => DateTime.now,
          })
        c.save!
        f.comments_count = f.comments.count
        f.save!
        c.me = current_user.redmine_user.id
        suc_res c.as_json({
              :include => {
                :user => {:methods => :full_name}
              },
              :methods => [:comments_disp_html, :created_on_words, :is_mine],
            })
      end
    rescue => e
      err_res e
    end
  end
end

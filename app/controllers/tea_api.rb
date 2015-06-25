Bizevo::App.controllers 'tea/api' do

  get :user, with: :id  do
    user_id = params[:id] == 'me' ? current_user.id : params[:id]
    u = Tea::User.find_by id: user_id
    halt 404 unless u
    suc_res u
  end

  get :party do
    start_index = params[:index].to_i
    limit = params[:size].present? ? params[:size].to_i : 10

    parties = Tea::Party.alived.limit(limit).offset(start_index).order(updated_at: :desc)
    ret = parties.map{ |p| transfer_party p }
    suc_res ret
  end

  get :party, with: :id do
    if params[:id] != 'new'
      p = Tea::Party.find_by id: params[:id]
      halt 404 unless p
      return suc_res transfer_party p
    end

    ActiveRecord::Base.transaction do
      p = Tea::Party.unsaved.owner_by(current_user).first
      return suc_res transfer_party p if p

      p = Tea::Party.create_new_party! current_user
      suc_res transfer_party p
    end
  end

  post :party, with: :id do
    p = Tea::Party.owner_by(current_user).find_by id: params[:id]
    halt 404 unless p

    json = posted_json %w/id title description venue start_date reseration capacity status/
    ActiveRecord::Base.transaction do
      p.assign_attributes json
      return err_res transfer_errors p.errors unless p.valid?
      p.save!
      suc_res id: p.id
    end
  end

  get :like, with: :id do
    likes = Tea::Like.liked_for params[:id]
    suc_res transfer_likes likes
  end

  post :like, with: :id do
    ActiveRecord::Base.transaction do
      l = Tea::Like.find_by id: params[:id], user_id: current_user.id
      Tea::Like.create! id: [params[:id], current_user.id] unless l
      likes = Tea::Like.liked_for params[:id]
      suc_res transfer_likes likes
    end
  end

  delete :like, with: :id do
    ActiveRecord::Base.transaction do
      l = Tea::Like.find_by id: params[:id], user_id: current_user.id
      l.delete if l
      likes = Tea::Like.liked_for params[:id]
      suc_res transfer_likes likes
    end
  end

  get :comments, with: :id do
    cs = Tea::Comment.commented_for params[:id]
    suc_res transfer_comments cs
  end

  get :comment, with: :id do
    c = Tea::Comment.find_by id: params[:id]
    halt 404 unless c
    suc_res transfer_comment c
  end

  post :comment, with: :parent_id do
    json = posted_json %w/text/
    ActiveRecord::Base.transaction do
      c = Tea::Comment.create_new_comment! params[:parent_id], current_user, json['text']
      suc_res transfer_comment c
    end
  end

  put :comment, with: :id do
    c = Tea::Comment.author_by(current_user).find_by id: params[:id]
    halt 404 if c
    json = posted_json %w/text/
    ActiveRecord::Base.transaction do
      c.assign_attributes json
      c.save!
      suc_res transfer_comment c
    end
  end

  get :attend, with: :id do
    likes = Tea::PartyAttend.attended_for params[:id]
    suc_res transfer_attends likes
  end

  post :attend, with: :id do
    ActiveRecord::Base.transaction do
      a = Tea::PartyAttend.find_by id: params[:id], user_id: current_user.id
      Tea::PartyAttend.create! id: [params[:id], current_user.id] unless a
      attends = Tea::PartyAttend.attended_for params[:id]
      suc_res transfer_attends attends
    end
  end

  delete :attend, with: :id do
    ActiveRecord::Base.transaction do
      a = Tea::PartyAttend.find_by id: params[:id], user_id: current_user.id
      a.delete if a
      attends = Tea::PartyAttend.attended_for params[:id]
      suc_res transfer_attends attends
    end
  end

end

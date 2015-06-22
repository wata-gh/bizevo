Bizevo::App.controllers 'tea/api' do

  sample_person = {
    id: 123,
    name: '太郎',
    image: 'https://pbs.twimg.com/profile_images/2579542348/l2b371d8r57tu6m4wu7i_400x400.jpeg',
  };

  get :user, with: :id  do
    u = Tea::User.find_by_id(params[:id] == 'me' ? current_user.id : params[:id])
    halt 404 unless u
    suc_res u
  end

  sample_party = {
    id: 123,
    status: 2,
    image: 'https://pbs.twimg.com/profile_images/1345198632/o036202881302519966804_400x400.jpg',
    title: 'テストタイトル',
    description: "ほげほげ\n改行\nもげもげ",
    date: '2009/08/11 08:14:45',
    venue: '6F研修室',
    reseration: 'http://www.amazon.co.jp/P.F.-%E3%83%89%E3%83%A9%E3%83%83%E3%82%AB%E3%83%BC/e/B000AP61TE',
    capacity: 23,
    owner: sample_person,
    update: '2009/08/11 08:14:45',
    tags: ['Java', 'Ruby', 'AngularJS'],
    attaches: {
      count: 0,
      attached: [],
    },
    likes: {
      count: 0,
      isLiked: false,
      liked: [],
    },
    attends: {
      count: 0,
      isAttended: false,
      attended: [],
    },
    comments: {
      count: 1,
      commented: [
        {
          id: 123,
          text: "コメントコメント\n改行\nこめんと",
          date: '2015/09/01 20:11:23',
          auther: sample_person,
          likes: {
            count: 0,
            isLiked: false,
            liked: [],
          }
        }
      ],
    }
  };

  get :party do
    start_index = params[:index].present? ? params[:index].to_i : 0;
    limit = params[:size].present? ? params[:size].to_i : 10;

    parties = Tea::Party.limit(limit).offset(start_index).reorder(updated_at: :desc)
    p parties
    ret = parties.map{ |p| transfer_party p }
    suc_res ret
  end

  get :party, with: :id do
    if params[:id] != 'new'
      p = Tea::Party.owner_by(current_user).find_by_id params[:id]
      halt 404 unless p
      return suc_res transfer_party p
    end

    ActiveRecord::Base.transaction do
      p = Tea::Party.unsaved.owner_by(current_user).first
      return suc_res transfer_party p if p

      p = Tea::Party.create_new_party current_user
      suc_res transfer_party p
    end
  end

  post :party, with: :id do
    p = Tea::Party.owner_by(current_user).find_by_id params[:id]
    halt 404 unless p

    json = posted_json %w/id title description venue start_date reseration capacity/
    ActiveRecord::Base.transaction do
      p.assign_attributes json
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





end

Bizevo::App.controllers 'tea/api' do

  sample_person = {
    id: 123,
    name: '太郎',
    image: 'https://pbs.twimg.com/profile_images/2579542348/l2b371d8r57tu6m4wu7i_400x400.jpeg',
  };

  get :user, with: :id  do
    suc_res sample_person
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
    suc_res [sample_party]
  end

  get :party, with: :id do
    suc_res sample_party
  end
end

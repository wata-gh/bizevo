FactoryGirl.define do
  factory :article, :class => Article do
    user_id '1'
    title 'spec投稿のタイトル'
    article '記事内容ですーーーーーーーーーーーー'
    like 0
  end
end

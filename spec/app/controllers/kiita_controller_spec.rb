require 'spec_helper'

RSpec.describe "KiitaController" do
  before :all do
    @user = FactoryGirl.create :user
    @articles = FactoryGirl.build :article
    @article_tags = FactoryGirl.create :article_tag
  end

  after :all do
    @user.destroy rescue nil
    @articles.destroy rescue nil
    @article_tags.destroy rescue nil
  end

  describe "#{__FILE__}" do
    describe "mypage 正常系" do
      it "ステータスコード200がかえってくること" do
        get 'kiita/mypage', {}, 'rack.session' => { 'sAMAccountName' => @user.name }
        last_response.status.should == 200
      end

    end
  end
end

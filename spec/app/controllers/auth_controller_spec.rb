require 'spec_helper'

RSpec.describe "AuthController" do
  before :all do
    @account = FactoryGirl.create :account
  end

  after :all do
    @account.destroy rescue nil
  end

  describe 'ログイン画面表示 正常系' do
    it 'ログイン画面表示 ステータスコード200が返ってくること' do
      get 'auth/login'
      last_response.status.should == 200
    end
  end

  describe 'ログイン 正常系' do
    it 'ログイン ステータスコード302が返ってくること' do
      post 'auth/login', {
          :email       => @account.email,
          :password    => 'abcd1234',
          :authenticity_token => 'a'
        }, 'rack.session' => { :_csrf_token => 'a' }
      last_response.status.should == 302
    end

    it 'ログイン失敗 ステータスコード302が返ってくること' do
      post 'auth/login', {
          :email       => @account.email,
          :password    => 'abcd',
          :authenticity_token => 'a'
        }, 'rack.session' => { :_csrf_token => 'a' }
      last_response.status.should == 302
    end

  end

  describe 'ログアウト 正常系' do
    it 'ログアウト ステータスコード302が返ってくること' do
      get 'auth/logout'
      last_response.status.should == 302
    end
  end
end

require 'spec_helper'

RSpec.describe User do
  before :all do
    @user = FactoryGirl.create :user
  end

  describe "#{__FILE__}" do
    describe "upload_file_name メソッドのテスト" do
      it "upload_file_nameが返ってくること" do
        expect(@user.upload_file_name).to be_truthy
      end

      it "２回読んでも結果が変わらないこと" do
        a = @user.upload_file_name
        b = @user.upload_file_name
        expect(a).to eq b
      end
    end

  end
end

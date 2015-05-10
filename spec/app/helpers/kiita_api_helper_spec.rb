require 'spec_helper'

RSpec.describe "Bizevo::App::KiitaApiHelper" do
  before :all do
    @articles = FactoryGirl.create :article
  end

  after :all do
    @articles.destroy rescue nil
  end

  describe "#{__FILE__}" do
    let(:helpers){ Class.new }
    before { helpers.extend Bizevo::App::KiitaApiHelper }
    subject { helpers }

    describe "increment_like のテスト" do
      it "like が増えること" do
        expect(helpers.increment_like(1).like).to eq 1
      end
    end
  end
end

require 'spec_helper'

RSpec.describe "Bizevo::App::KiitaHelper" do
  describe "#{__FILE__}" do
    let(:helpers){ Class.new }
    before { helpers.extend Bizevo::App::KiitaHelper }

    describe '#mark_down_parse' do
      it 'マークダウン記法がhtmlに変換されること' do
        expect(helpers.mark_down_parse('```ruby¥r¥n3.time do ¥r¥n```')).to eq '<p><code>ruby¥r¥n3.time do ¥r¥n</code></p>
'
      end
    end

    describe '#save_article' do
      it 'データが登録されること' do
        params = {
          :article => {
            :title => 'titleです',
            :article => 'articleの中身です',
          },
          :article_tag => { :tag => ['tag'], },
        }
        helpers.save_article params
        article = Article.find(1)
        expect(article.title).to eq 'titleです'
        expect(article.article_tags.first.tag).to eq 'tag'
      end
    end

    describe '#save_new_tag' do
      context 'DBにタグデータなし' do
        it 'データが0件の状態で登録した場合に、データが登録されること' do
          helpers.save_new_tag ['Ruby']
          expect(Tag.find('Ruby')).to be_truthy
        end
      end

      context 'DBにタグデータあり' do
        before do
          # タグデータを登録
          helpers.save_new_tag ['Ruby']
        end

        it '同じタグを登録しようとした場合' do
          # 普通に insert したときも truthy だし微妙
          expect(helpers.save_new_tag ['Ruby']).to be_truthy
        end

        it '同じタグと違うタグの2つを登録しようとした場合' do
          # 2個登録しても戻り値は最後の結果だな。。
          expect(helpers.save_new_tag ['Ruby','activerecord']).to be_truthy
        end
      end
    end

    describe '#update_article' do
      context 'DBにデータなし' do
        it '新規登録ができること' do
          params = {:article => {
              :title => 'titleです',
              :article => 'articleの中身です',
            }}
          expect(helpers.update_article params).to be_truthy
        end
      end

      context 'DBにデータあり' do
        before do
          params = {:article => {
              :title => 'titleです',
              :article => 'articleの中身です',
            }}
          helpers.update_article params
        end

        it '更新ができること' do
          params = {:article => {
              :id => 1,
              :title => 'titleです。更新です。',
              :article => 'articleの中身です。更新です。',
            }}
          helpers.update_article params
          @article = Article.find(1)
          expect(@article.title).to eq 'titleです。更新です。'
          expect(@article.article).to eq 'articleの中身です。更新です。'
        end
      end
    end

    describe '#update_article_tag' do
      before do
        params = {:article => {
            :title => 'titleです',
            :article => 'articleの中身です',
          }}
        @article = helpers.update_article params
      end

      context '新規' do
        params = {:article_tag => {
          :tag => ['Ruby'],
        }}
        it '新規登録ができること' do
          helpers.update_article_tag params
          expect(ArticleTag.where('article_id=?', 1)).to be_truthy
        end
      end

      context '削除' do
        before do
          params = {:article_tag => {
            :tag => ['Ruby','activerecord'],
          }}
          helpers.update_article_tag params
        end

        it '差分が削除されること' do
          params = {:article_tag => {
            :tag => ['Ruby'],
          }}
          helpers.update_article_tag params
          expect{ArticleTag.find(2)}.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end

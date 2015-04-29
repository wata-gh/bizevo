module Bizevo
  class App
    module KiitaHelper
      def mark_down_parse text, extensions = {}
        extensions = {
          :fenced_code_blocks => true,
          :tables => true,
        }
        Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions).render text
      end

      def save_new_tag params
        #未登録タグの登録
        raise 'タグを入力してください。' if params.empty?
        params.split(',').each do |tag|
          Tag.find_or_create_by(:tag => tag)
        end
      end

      def save_article params
        ActiveRecord::Base.transaction do
          @article = Article.create! params[:article]
          save_new_tag params[:article_tag][:tag]
          params[:article_tag][:tag].split(',').each do |t|
            @article.article_tags.create! article_id: @article.id, tag: t
          end
        end
      end

      def update_article params
        @article = Article.where(:id => params[:article][:id]).first_or_initialize
        @article.assign_attributes params[:article]
        @article.save!
      end

      def update_article_tag params
        # DBからセレクトした値から変更なしのデータを引いて　削除対象を出す
        select_article_tags = ArticleTag.where article_id: @article.id
        no_change_tags = []
        params[:article_tag][:tag].split(',').each do |tag|
          articletag = ArticleTag.find_or_initialize_by({article_id: @article.id, tag: tag})
          if articletag.new_record? then
            articletag.save!
          end
          no_change_tags << articletag
        end
        destroy_tags = select_article_tags - no_change_tags
        if destroy_tags.present?
          destroy_tags.map &:destroy!
        end
      end

      def destroy_article article
        article.destroy!
      end
    end

    helpers KiitaHelper
  end
end

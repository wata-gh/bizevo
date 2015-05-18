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
        params.each do |tag|
          Tag.find_or_create_by(:tag => tag)
        end
      end

      def save_article params
        ActiveRecord::Base.transaction do
          @article = Article.new(params[:article])
          @article.save!
          raise 'タグを入力してください。' unless params[:article_tag].present?
          save_new_tag params[:article_tag][:tag]
          params[:article_tag][:tag].each do |t|
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
        # 全消しして、全インサートでいい気がしてきた。
        select_article_tags = ArticleTag.where article_id: @article.id
        select_article_tags.each {|tag| tag.destroy! } if select_article_tags
        params[:article_tag][:tag].each do |tag|
          articletag = ArticleTag.find_or_initialize_by({article_id: @article.id, tag: tag})
          if articletag.new_record? then
            articletag.save!
          end
        end
      end

      def destroy_article article
        article.destroy!
      end

    end

    helpers KiitaHelper
  end
end

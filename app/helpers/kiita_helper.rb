module Bizevo
  class App
    module KiitaHelper
      def mark_down_parse text, extensions = {}
        Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {}).render text
      end

      def save_new_tag params
        #未登録タグの登録
        params.each do |tag|
          Tag.find_or_create_by(:tag => tag)
        end
      end

      def save_article params
        begin
          ActiveRecord::Base.transaction do
            @article = Article.where(:id => params[:article][:id]).first_or_initialize
            @article.assign_attributes params[:article]
            @article.save!

            save_new_tag params[:article_tag][:tag]

            # 新規タグのinsert、削除タグの delete を行う
            @select_article_tags = ArticleTag.where('article_id=?', @article.id)
            @new_article_tags = []
            @no_change_tags = []
            params[:article_tag][:tag].each do |tag|
              articletag = ArticleTag.find_or_initialize_by({:article_id => @article.id, :tag => tag})
              if articletag.new_record? then
                @new_article_tags << articletag
              else
                @no_change_tags << articletag
              end
            end

            # DBからセレクトした値から変更なしのデータを引いて　削除対象を出す
            @destroy_tags = @select_article_tags - @no_change_tags

            @new_article_tags.each {|tag| tag.save! }
            @destroy_tags.each {|tag| tag.destroy! }

          end
        rescue => e
          p e
          halt 404
        end

      end
    end

    helpers KiitaHelper
  end
end

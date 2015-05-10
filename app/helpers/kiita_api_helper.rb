module Bizevo
  class App
    module KiitaApiHelper

      def increment_like article_id
        article = Article.find_by_id article_id
        return nil unless article
        article.lock!
        article.like = article.like + 1
        return article if article.save
        nil
      end
    end

    helpers KiitaApiHelper
  end
end

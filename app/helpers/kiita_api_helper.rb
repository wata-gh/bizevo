module Bizevo
  class App
    module KiitaApiHelper

      def increment_like article_id
        article = Article.find_by :id => article_id
        return nil unless article
        article.lock!
        article.likes += 1
        article.save ? article : nil
      end
    end

    helpers KiitaApiHelper
  end
end

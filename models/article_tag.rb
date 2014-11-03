class ArticleTag < ActiveRecord::Base
  self.primary_keys = :article_id, :tag

  belongs_to :tags, foreign_key: :tag
  belongs_to :articles, foreign_key: :article_id
end

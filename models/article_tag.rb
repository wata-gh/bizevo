class ArticleTag < ActiveRecord::Base
  self.primary_keys = :article_id, :tag

  has_one :articles
  #belongs_to :tag, foreign_key: :tag
  belongs_to :article, foreign_key: :article_id

  validates_presence_of :article_id, :tag
end

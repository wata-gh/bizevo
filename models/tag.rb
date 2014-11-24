class Tag < ActiveRecord::Base
  self.primary_key = :tag

  has_many :article_tags
  has_many :articles, through: :article_tags
end

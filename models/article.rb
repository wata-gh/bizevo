class Article < ActiveRecord::Base

  has_many :article_tags
  has_many :tags, through: :article_tags
end

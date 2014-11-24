class Article < ActiveRecord::Base
  after_save :save_article_tags
  private
  def save_article_tags
    p self
    #self.article_tags.create! self.article_tags
  end

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  validates_presence_of :title
  validates_presence_of :article
end

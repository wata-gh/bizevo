class Article < ActiveRecord::Base
  after_save :save_article_tags

  def mine? id
    self.user_id == id
  end

  def get_created_at
    self.created_at.strftime '%Y/%m/%d'
  end

  def get_created_at_ago
    (Date.today - self.created_at.to_date).to_i
  end

  private
  def save_article_tags
    p self
    #self.article_tags.create! self.article_tags
  end

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  validates_presence_of :title
  validates_presence_of :article
  validate :tag_check

  def tag_check
    p self
  end

  paginates_per 5 
end

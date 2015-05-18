class Article < ActiveRecord::Base
  after_save :save_article_tags

  def mine? id
    self.user_id == id
  end

  def get_created_at
    self.created_at.strftime '%Y/%m/%d'
  end

  private
  def save_article_tags
  end

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :article

  paginates_per 3
end

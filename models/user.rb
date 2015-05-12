require 'digest/md5'

class User < ActiveRecord::Base
  include Bizevo::Helpers::S3Helper
  attr :filename

  def upload_file_name
    file = self.name + Time.now.to_s
    @filename ||= Digest::MD5.hexdigest(self.name)[0,2] + '/' + Digest::MD5.hexdigest(file)
    @filename
  end

  def get_image_path
    self.icon_path ? "http://#{S3_CONFIG['host']}/#{self.icon_path}.png" : "/images/noimage.png"
  end

  def get_thumbnail_path
    self.icon_path ? "http://#{S3_CONFIG['host']}/thumbnail/#{self.icon_path}.png" : "/images/noimage.png"
  end

  has_many :articles
end

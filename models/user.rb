require 'digest/md5'

class User < ActiveRecord::Base
  include Bizevo::Helpers::S3Helper
  attr :filename

  def upload_file_name
    file = self.name + Time.now.to_s
    @filename ||= Digest::MD5.hexdigest(self.name)[0,2] + '/' + Digest::MD5.hexdigest(file)
    @filename
  end

  def get_image_path1
    'http://' + S3_CONFIG['host'] + '/' + self.icon_path + '.png'
  end
end

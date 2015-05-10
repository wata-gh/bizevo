require 'rmagick'

module Bizevo
  module Helpers
    module S3Helper

      def s3_upload file
        image = Magick::Image.from_blob(File.read(file)).first
        image.strip!
        image.format = 'png'
        thumbnail = image.thumbnail(48,48)
        s3 = s3_access
        s3.put_object(
          bucket: S3_CONFIG['bucket'],
          body: image.to_blob,
          key: upload_file_name + '.png'
        )
        s3.put_object(
          bucket: S3_CONFIG['bucket'],
          body: thumbnail.to_blob,
          key: 'thumbnail/' + upload_file_name + '.png'
        )
      end

      private
      def s3_access
        Aws::S3::Client.new(
          region: 'ap-northeast-1',
          access_key_id: ENV['S3_ACCESS_KEY'],
          secret_access_key: ENV['S3_SEACRET_KEY']
        )
      end
    end
  end
end

module Bizevo
  class App
    module TeaApiHelper
      def transfer_party party
        opts = {
          only: [
            :id,
            :status,
            :image,
            :title,
            :description,
            :start_date,
            :venue,
            :reseration,
            :capacity,
            :update_date,

            :owner,
          ],
          methods: [:owner, :image, :update_date],
        }
        h = party.as_json opts
        date_conv = %w/start_date update_date/
        h.each do |key, val|
          h[key] = val.strftime '%Y/%m/%d %T' if date_conv.include?(key) && val.present?
        end
        h['likes'] = transfer_likes party.likes
        h['attaches'] = {
          count: 0,
          attached: [],
        }
        h.deep_transform_keys! {|k| k.to_s.camelize :lower}
      end
    end

    def transfer_likes likes = []
      h = {
        count: likes.length,
        is_liked: likes.any? {|v| v.user_id == current_user.id},
        liked: likes.map {|v| v.user},
      }
      h.deep_transform_keys! {|k| k.to_s.camelize :lower}
    end

    def posted_json includes = []
      h = JSON.parse request.body.read
      h.deep_transform_keys! {|k| k.to_s.underscore }
      return h if includes.empty?
      h.each_with_object({}) do |(key, val), obj|
        obj[key] = val if includes.include? key
      end
    end

    helpers TeaApiHelper
  end
end

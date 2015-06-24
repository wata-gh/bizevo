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
        h['comments'] = transfer_comments party.comments
        h['attends'] = transfer_attends party.attends
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

    def transfer_comments comments = []
      h = {
        count: comments.length,
        commented: comments.map {|v| transfer_comment v},
      }
      h.deep_transform_keys! {|k| k.to_s.camelize :lower}
    end

    def transfer_comment comment = nil
      return {} unless comment.present?
      opts = {
        only: ['id', 'parent_id', 'text', 'author', 'post_date'],
        methods: ['author', 'post_date'],
      }
      h = comment.as_json opts
      h['post_date'] = comment.post_date.strftime '%Y/%m/%d %T' if comment.post_date.present?
      h['likes'] = transfer_likes comment.likes

      h.deep_transform_keys! {|k| k.to_s.camelize :lower}
    end

    def transfer_attends attends = []
      h = {
        count: attends.length,
        is_attended: attends.any? {|v| v.user_id == current_user.id},
        attended: attends.map {|v| v.user},
      }
      h.deep_transform_keys! {|k| k.to_s.camelize :lower}
    end

    def transfer_errors errors = {}
      {errors: errors, messages: errors.full_messages}
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

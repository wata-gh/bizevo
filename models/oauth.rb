class Oauth < ActiveRecord::Base
  enum provider: [:slack]

  def channels
    json = slack_api 'channels.list'
    json['channels']
  end

  def groups
    json = slack_api 'groups.list'
    json['groups']
  end

  def channel_info id
    json = slack_api 'channels.info', :channel => id
    return nil unless json['ok']
    json['channel']
  end

  def group_info id
    json = slack_api 'groups.info', :channel => id
    return nil unless json['ok']
    json['group']
  end

  def channel_history id
    json = slack_api 'channels.history', :channel => id, :count => 100
    json['messages']
  end

  def group_history id
    json = slack_api 'groups.history', :channel => id, :count => 100
    json['messages']
  end

  def slack_api method, params = nil
    query = ''
    if params.present?
      query = '&' + params.map {|k, v| "#{k}=#{v}"}.join('&')
    end
    Oauth::get_json "https://slack.com/api/#{method}?token=#{self.access_token}#{query}"
  end

  def self.slack_oauth code
    params = APP_CONFIG[:slack].dup
    params[:code] = code
    params[:redirect_uri] = "#{APP_CONFIG[:base_url]}#{params[:redirect_uri]}"
    query = '&' + params.map {|k, v| "#{k}=#{v}"}.join('&')
    Oauth::get_json "https://slack.com/api/oauth.access?#{query}"
  end

  def self.get_json location, limit = 10
    raise ArgumentError, 'too many HTTP redirects' if limit == 0
    uri = URI.parse(location)
    begin
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 10
        http.get uri.request_uri
      end
      case response
        when Net::HTTPSuccess
          json = response.body
          JSON.parse json
        when Net::HTTPRedirection
          location = response['location']
          warn "redirected to #{location}"
          get_json location, limit - 1
        else
          raise [uri.to_s, response.value].join(' : ')
      end
    end
  end
end

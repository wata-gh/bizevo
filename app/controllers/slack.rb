Bizevo::App.controllers :slack do

  get :index do
    @oauth = Oauth.slack.find_by :user_id => current_user.user.id
    render 'slack/index'
  end

  get :archives, :with => :id do
    o = Oauth.slack.find_by :user_id => current_user.user.id
    halt 404 unless o

    id = params[:id]
    # channel => C[0-9A-Z]+ group => G[0-9A-Z]+
    @messages = if id.start_with? 'C'
                  @info = o.channel_info id
                  halt 404 unless @info
                  o.channel_history id
                else
                  @info = o.group_info id
                  halt 404 unless @info
                  o.group_history id
                end
    render 'slack/archives'
  end

  get :oauth do
    json = Oauth.slack_oauth params[:code]
    redirect(url(:slack, :index), :error => json['error']) unless json['ok']
    o = Oauth.slack.first_or_initialize :user_id => current_user.user.id
    o.access_token = json['access_token']
    o.save
    redirect url(:slack, :index), :success => 'slack認証に成功しました'
  end
end

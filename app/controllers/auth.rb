Bizevo::App.controllers :auth do

  layout :no_auth

  get :login do
    @account = Account.new
    render :login
  end

  post :login do
    user = ActiveUser.authenticate params[:email], params[:password]
    unless user
      redirect_to url(:auth, :login), :error => 'email or password invalid.'
    end
    set_current_user user
    redirect '/'
  end

  get :logout do
    session.clear
    redirect url(:auth, :login)
  end
end

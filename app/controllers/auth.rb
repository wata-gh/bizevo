Bizevo::App.controllers :auth do

  layout :no_auth

  get :login do
    @account = Account.new
    render :login
  end

  post :login do
    account = Account.authenticate params[:email], params[:password]
    unless account
      redirect_to url(:auth, :login), :error => 'email or password invalid.'
    end
    # TODO redirect to somewhere like dashboard...
    redirect url(:kiita, :index)
  end

  get :logout do
    # TODO session invalidate
    redirect url(:auth, :login)
  end
end

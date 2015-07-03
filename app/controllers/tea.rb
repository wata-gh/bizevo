Bizevo::App.controllers :tea do
  layout :tea_layouts
  get :index do
    redirect url(:tea, :top)
  end
  get :top do
    response.set_cookie "X-CSRF-Token", :value => csrf_token
    render "tea/index"
  end
end

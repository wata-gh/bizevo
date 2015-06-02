Bizevo::App.controllers :tea do
  layout :tea_layouts
  get :index do
    redirect url(:tea, :top)
  end
  get :top do
    render "tea/index"
  end
end

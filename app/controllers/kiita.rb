Bizevo::App.controllers :kiita do

  get :index do
    'hello'
  end

  get :new do
    render 'kiita/new'
  end

  get :view, :with => :id do
    @article = Article.find(params[:id])
    @mdText = markDownParse(@article.article)
    render 'kiita/view'
  end

  post :create do
    tag_data = ''
    params[:draft_item][:tag_data].each do |value|
      tag_data << value[:name]
    end
    article_param = {
      :title => params[:draft_item][:title],
      :article => params[:draft_item][:article],
      :tag => tag_data
      }
    @article = Article.new(article_param)
    if @article.save
      redirect(url(:kiita, :view, :id => @article.id))
    else
      p 'failed'
    end
    'hello'
  end

end

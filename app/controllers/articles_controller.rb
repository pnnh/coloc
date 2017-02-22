class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def show
      @article = Article.find(params[:id])
      @content = @article.content
  end

  def create
    @article = current_user.articles.new(params.require(:article).permit(:title, :text))
    if @article.save
      content = current_user.contents.create(parent_id: params[:content_id], entity_type: 'Article',
                                             entity_id: @article.id, name: @article.title)
      redirect_to view_context.content_entity_url(content)
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params.require(:article).permit(:title, :text))
      redirect_to view_context.content_entity_url
    end
  end

  def destroy
    Article.find(params[:id]).destroy
  end
end

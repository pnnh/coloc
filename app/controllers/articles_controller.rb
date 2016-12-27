class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def show
      @article = Article.find(params[:id])
      @content = Content.find(params[:content_id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :content))
    if @article.save
      content = Content.create(parent_id: params[:content_id], entity_type: "Article", entity_id: @article.id, name: @article.title, description: @article.content)
      redirect_to show_content_url(content_id: content.id, id: @article.id)
    else
      render 'new'
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params.require(:article).permit(:title, :content))
      redirect_to show_article_url(id:@article.id)
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_url
  end

  private

  def save_pdf(item)
    file_name = "#{Rails.root}/public/pdf/" + item.title + ".pdf"
    pdf = LatexToPdf.generate_pdf(item.content, {:command=>'xelatex'})
    File.open(file=file_name, 'w:binary') do |io|
      io.write(pdf)
    end
  end
end

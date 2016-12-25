class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def show
    content_id = params[:content_id]
    if !content_id.nil?
      @article = Content.find(content_id.to_i).entity
    else
      @article = Article.find(params[:id])
    end
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :content, :markup))
    if @article.save
      content = Content.find(params[:parent_id])
      content.contents.create(entity_type: "Article", entity_id: @article.id, name: @article.title, description: @article.content)
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def edit
    @item = Article.find(params[:id])
  end

  def update
    @item = Article.find(params[:id])
    if @item.update_attributes(params.require(:item).permit(:markup, :contents))
      #save_pdf(@item)
      redirect_to @item
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

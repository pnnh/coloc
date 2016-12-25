class ArticlesController < ApplicationController
  def new
    @item = Article.new
    @item.title = params[:title]
  end

  def show
    id = params[:id]
    if(id.to_i > 0)
      @item = Article.find id
    elsif(!id.blank?)
      @item = Article.friendly.find id rescue nil
      if(@item.nil?)
        @keyword = id
        @items = Article.where("title LIKE :q", q: "%#{@keyword}%").limit(100)
        render 'index'
      end
    end

    #send_data(pdf, :filename=>item.title + '.pdf', :disposition => "inline", :type => "application/pdf; charset=utf-8")
  end

  def create
    @item = Article.new(params.require(:item).permit(:title, :content, :markup))
    if @item.save
      #save_pdf(@item)
      @item.parents.create view_context.parent_params
      redirect_to @item
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

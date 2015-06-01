class ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def index
    @keyword = params[:keyword]
    @items = (!@keyword.empty? ? Item.where("title LIKE :q", q: "%#{@keyword}%") : Item).paginate(page: params[:page])
  end

  def show
    @item = Item.find(params[:id])
    #send_data(pdf, :filename=>item.title + '.pdf', :disposition => "inline", :type => "application/pdf; charset=utf-8")
  end

  def create
    @item = Item.new(params.require(:item).permit(:title, :content))
    if @item.save
      save_pdf(@item)
      redirect_to @item
    else
      render 'new'
    end
  end
  
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params.require(:item).permit(:content))
      save_pdf(@item)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to items_url
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

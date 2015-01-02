class ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def index
    @items = Item.paginate(page: params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params.require(:item).permit(:title, :content))
    if @item.save
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
      flash[:success] = "Item updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item destroyed."
    redirect_to items_url
  end
end

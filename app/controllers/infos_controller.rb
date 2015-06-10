class InfosController < ApplicationController
   def index
     @keyword = params[:keyword]
     @limit = 3
    if @keyword.nil? || @keyword.empty?
      @items = Arrary.new
      @users = Array.new
    else
      @items = Item.where("title LIKE :q", q: "%#{@keyword}%").limit(@limit)
      @users = User.where("name LIKE :q", q: "%#{@keyword}%").limit(@limit)
    end
  end
end

class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end
  
  def index
    @tags = Tag.paginate(page: params[:page])
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  private

    def tag_params
      params.require(:tag).permit(:title, :contents)
    end
end

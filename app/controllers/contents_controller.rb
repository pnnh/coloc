class ContentsController < ApplicationController
  def index
    id = params[:id].to_i
    @content = Content.find(id)
    @contents = Content.where(content_id: id)
  end

  def show
    @content = Content.find(params[:id])
  end
end

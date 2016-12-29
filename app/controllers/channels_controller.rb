class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def index
  end

  def show
    @channel = Channel.find(params[:id])
    @content_id = params[:content_id].to_i
    @contents = Content.where(parent_id: @content_id)
  end

  def create
    @channel = Channel.new(params.require(:channel).permit(:name, :description))
    if @channel.save
      content = Content.create(parent_id: params[:content_id], entity_type: "Channel", entity_id: @channel.id, name: @channel.name, description: @channel.description)
      redirect_to view_context.content(content)
    else
       render 'new'
    end
  end

  def edit
    @channel = Channel.find params[:id]
  end

  def update
    @channel = Channel.find params[:id]
    if @channel.update_attributes(params.require(:channel).permit(:name, :description))
      redirect_to view_context.content_current
    else
      render 'edit'
    end
  end
end

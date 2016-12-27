class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def index
  end

  def show
    @channel = Channel.find(params[:id])
    @content = Content.find(params[:content_id])
    @contents = Content.where(parent_id: @content.id)
  end

  def create
    @channel = Channel.new(params.require(:channel).permit(:name, :description))
    if @channel.save
      content = Content.create(parent_id: params[:content_id], entity_type: "Channel", entity_id: @channel.id, name: @channel.name, description: @channel.description)
      redirect_to show_content_url(content_id: content.id, id: @channel.id)
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
      redirect_to show_channel_url(id: @channel.id)
    else
      render 'edit'
    end
  end
end

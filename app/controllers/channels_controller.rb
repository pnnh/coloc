class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def index
    @channel = Channel.find params[:id].to_i
    @contents = @channel.contents
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def create
    @channel = Channel.new(params.require(:channel).permit(:name, :description))
    if @channel.save
      content = Content.find(params[:parent_id])
      content.contents.create(entity_type: "Channel", entity_id: @channel.id, name: @channel.name, description: @channel.description)
      redirect_to @channel
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
      redirect_to @channel
    else
      render 'edit'
    end
  end
end

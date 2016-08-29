class ChannelsController < ApplicationController
  def new
    channel_id = params[:channel_id]
    if channel_id.nil?
      channel_id = 0
    end
    @channel = Channel.new(channel_id:channel_id)
  end

  def show
    id = params[:id]
    @channel = Channel.find id
  end

  def create
    @channel = Channel.new(params.require(:channel).permit(:channel_id, :name, :description))
    if @channel.save
      redirect_to content_index_url(params[:channel][:channel_id])
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

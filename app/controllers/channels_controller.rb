class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def show
    id = params[:id] || 1

    @channel = Channel.find id
    @contents = Content.where parent_type:"Channel", parent_id:id
  end

  def create
    @channel = Channel.new(params.require(:channel).permit(:channel_id, :name, :description))
    if @channel.save
      @channel.parents.create view_context.parent_params
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

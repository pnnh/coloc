class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def show
    id = (params[:id].to_i || 1).to_i

    start = (params[:start] || 1).to_i

    @contents = Content.where(parent_type:"Channel", parent_id:id)
                    .offset(start - 1).limit(5)

    if start > 1
      render partial: "contents"
    else
      @channel = Channel.find id
    end
  end

  def create
    @channel = Channel.new(params.require(:channel).permit(:name, :description))
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

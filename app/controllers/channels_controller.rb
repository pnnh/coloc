class ChannelsController < ApplicationController
  def new
  end

  def index
    keyword = params[:keyword]
    if !keyword.nil? && !keyword.blank? and keyword.length > 1
      @channels = Channel.where('title like ? or tags like ?', "%#{keyword}%", "%#{keyword}%").limit(100)
    else
      @channels = Channel.all.limit(100)
    end
  end

  def show
    @channel = Channel.find(params[:id])
    @content_id = params[:content_id].to_i
    @contents = Content.where(parent_id: @content_id)
  end

  def create
    @channel = current_user.channels.new(params.require(:channel).permit(:name, :description))
    if @channel.save
      content = current_user.contents.create(parent_id: params[:content_id], entity_type: 'Channel', entity_id: @channel.id, name: @channel.name)
      redirect_to view_context.content_entity_url(content)
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
      redirect_to view_context.content_entity_url
    else
      render 'edit'
    end
  end
end

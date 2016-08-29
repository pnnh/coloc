class ContentController < ApplicationController
  def index
    @channel_id = params[:channel_id]

    if @channel_id.nil? or @channel_id.blank?
      @channel_id = 0
      @channels = Channel.where channel_id:@channel_id
    else
      channel = Channel.find @channel_id
      @channels = channel.channels
    end
  end

  def new

    @channel_id = params[:channel_id]

    if @channel_id.nil? or @channel_id.blank?
      @channel_id = 0
    end
  end
end

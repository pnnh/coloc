class ContentsController < ApplicationController
  def index
      @channel = Channel.find(params[:channel_id])
      @contents = @channel.contents
  end
end

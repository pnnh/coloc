class ChannelsController < ApplicationController
    def new
        @channel = Channel.new
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
    end

    def create
        p = params[:channel]
        @channel = Channel.new(title: p[:title], description: p[:description],
            tags: p[:tags], user_id: current_user.id, ctype: 'Article')
        if @channel.save
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
        if @channel.update_attributes(params.require(:channel).permit(:title, :description, :tags))
            redirect_to @channel
        end
    end
end

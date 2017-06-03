class ChannelsController < ApplicationController
    def new
        unless signed_in?
            redirect_to root_path
            return
        end
        @channel = Channel.new
    end

    def index
        @visible = params[:visible].to_i rescue 0
        @visible = 0 if @visible != 0 && @visible != 1
        # 未登陆不允许查看私有频道
        if @visible == 1 && !signed_in?
            redirect_to root_path
            return
        end

        query = 'SELECT c.id, c.user_id, c.tags, c.description, c.title, c.ctype, c.visible
FROM "channels" as c where c.visible = ? '
        query_params = [@visible]
        if @visible == 1  # 私有频道需限制用户id
            query << ' and user_id = ?'
            query_params << current_user.id
        end
        keyword = params[:keyword]
        unless keyword.blank?
            query << ' and c.title like ? or c.tags like ?'
            query_params << "%#{keyword}%" << "%#{keyword}%"
        end
        query << ' limit 100;'
        @channels = execsql(query, query_params)

        @tags = []
        @channels.each do |c|
            unless c['tags'].blank?
                @tags |= c['tags'].split(',')
            end
        end
    end

    def show
        @channel = Channel.find(params[:id])
    end

    def create
        p = params[:channel]
        @channel = Channel.new(title: p[:title], description: p[:description],
            tags: p[:tags], user_id: current_user.id, ctype: 'Article', plus: 0,
           minus: 0, visible: p[:visible])
        if @channel.save
            redirect_to @channel.contents_path
        else
            render 'new'
        end
    end

    def edit
        @channel = Channel.find params[:id]
    end

    def update
        @channel = Channel.find params[:id]
        if @channel.update_attributes(params.require(:channel).
                permit(:title, :description, :tags))
            redirect_to @channel.contents_path
        end
    end
end

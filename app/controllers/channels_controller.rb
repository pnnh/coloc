class ChannelsController < ApplicationController
    def new
        @channel = Channel.new
    end

    def index
        keyword = params[:keyword]
        query = 'SELECT c.id, c.user_id, c.tags, c.description, c.title, c.ctype
FROM "channels" as c'
        query_params = [query]
        unless keyword.blank?
            query += ' where c.title ~* ? or c.tags ~* ?'
            query_params = [query, keyword, keyword]
        end
        query += ' limit 100;'
        query_params[0] = query
        query = ActiveRecord::Base.send :sanitize_sql, query_params
        @channels = ActiveRecord::Base.connection.execute(query)
    end

    def show
        @channel = Channel.find(params[:id])
    end

    def create
        p = params[:channel]
        @channel = Channel.new(title: p[:title], description: p[:description],
            tags: p[:tags], user_id: current_user.id, ctype: 'Article', plus: 0, minus: 0)
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

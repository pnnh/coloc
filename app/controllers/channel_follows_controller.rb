class ChannelFollowsController < ApplicationController
    def index
        keyword = params[:keyword]
        query = 'select c.id as channel_id, uc.id as follow_id, c.tags, c.description, c.title,
    c.ctype, coalesce(uc.favorite, 0) as favorite, coalesce(uc.vote, 0) as vote,
    uc.updated_at
FROM "channels" as c left join "channel_follows" as uc ON c."id" = uc."channel_id"
where uc.user_id = ? and uc.favorite = 1 '
        query_params = [query, current_user.id]
        unless keyword.blank?
            query += ' and (c.title like ? or tags like ?)'
            query_params.push("%#{keyword}%", "%#{keyword}%")
        end
        query += ' limit 100;'
        query_params[0] = query
        query = ActiveRecord::Base.send :sanitize_sql, query_params
        @follows = ActiveRecord::Base.connection.execute(query)
    end

    def create
        channel_id = params[:channel_id]
        cf = ChannelFollow.find_by(user_id: current_user.id, channel_id: channel_id)
        if cf.nil?
            cf = ChannelFollow.new(user_id: current_user.id, channel_id: channel_id)
        end
        cf.favorite = 1
        if cf.save
            redirect_back fallback_location: channel_path(channel_id)
        end
    end

    def destroy
        cf = ChannelFollow.find(params[:id])
        if !cf.nil?
            cf.favorite = 0
            if cf.save
                redirect_back fallback_location: channel_follows_path
            end
        end
    end
end

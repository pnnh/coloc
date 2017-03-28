class FavoriteChannelsController < ApplicationController
    def index
        keyword = params[:keyword]
        query = 'SELECT c.id, c.user_id, c.tags, c.description, c.title,
                uc.favorite, c.ctype, uc.vote
            FROM "channels" as c INNER JOIN "user_channels" as uc ON
                c."id" = uc."channel_id"
            WHERE uc."user_id" = ?'
        query_params = [query, 1]
        unless keyword.blank?
            query += ' and c.title like ? or tags like ?'
            query_params = [query, 1, keyword, keyword]
        end
        query += ' limit 100;'
        query_params[0] = query
        query = ActiveRecord::Base.send :sanitize_sql, query_params
        @favorites = ActiveRecord::Base.connection.execute(query)
    end

    def create
        favorite = params[:favorite].to_i

        user_channel = current_user.user_channels.find_by(channel_id: params[:channel_id])
        if user_channel.nil?
            user_channel = current_user.user_channels.new(channel_id: params[:channel_id])
        end

        if favorite != user_channel.favorite
            user_channel.favorite = favorite

            if user_channel.save
                redirect_back
            end
        end
        redirect_back
    end
end

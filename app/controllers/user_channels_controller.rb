class UserChannelsController < ApplicationController
    def index
        keyword = params[:keyword]
        if !keyword.nil? && !keyword.blank? and keyword.length > 1
            @user_channels = current_user.user_channels.where('title like ? or tags like ?',
                "%#{keyword}%", "%#{keyword}%").limit(100)
        else
            @user_channels = current_user.user_channels.all.limit(100)
        end
    end

    def create
        plus = params[:plus]
        minus = params[:minus]
        attention = params[:attention]

        redirect_back if plus.blank? && minus.blank? && attention.blank?

        user_channel = current_user.user_channels.find_by(channel_id: params[:channel_id]) ||
                current_user.user_channels.new(channel_id: params[:channel_id])

        if !plus.blank?
            plus = plus.to_i

            if plus != user_channel.plus
                user_channel.channel.plus += plus - user_channel.plus
                user_channel.plus = plus
            end
        elsif !minus.blank?
            minus = minus.to_i
            if minus != user_channel.minus
                user_channel.channel.minus += minus - user_channel.minus
                user_channel.minus = minus
            end
        else
            attention = attention.to_i
            if attention != user_channel.attention
                user_channel.attention = attention
            end
        end

        if user_channel.save && user_channel.channel.save
            redirect_back
        end
    end

    private
        def redirect_back
            redirect_to(params[:back] || root_path)
        end
end

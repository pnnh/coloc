class Channel < ActiveRecord::Base
    belongs_to :user
    has_many :articles

    validates :title, presence: true

    def contents_path
        '/channels/' + id.to_s + '/' + ctype.pluralize.downcase
    end

    def favorite_id(user_id)
        if !@favorite_id.nil?
            @favorite_id
        else
            cf = ChannelFollow.find_by(user_id: user_id, channel_id: id)
            @favorite_id = 0
            @favorite_id = cf.id if !cf.nil? && cf.favorite == 1
        end
    end
end
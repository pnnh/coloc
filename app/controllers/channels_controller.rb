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
        query << 'order by updated_at desc limit 100;'
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

        query = 'select articles.*, tmp.tag
from articles join
  (select article_tags.article_id,article_tags.tag,channel_tags.score channel_score, article_tags.score article_score,
     row_number() over(PARTITION BY article_tags.article_id order by channel_tags.score asc, article_tags.score ASC) rank
   from channel_tags join article_tags on article_tags.tag = channel_tags.tag
   where channel_tags.channel_id = ?) as tmp
  on articles.id = tmp.article_id
where tmp.rank = 1 '
        query_params = [@channel.id]
        keyword = params[:keyword]
        unless keyword.blank?
            query << ' and (articles.title like ? or articles.tags like ?)'
            query_params << "%#{keyword}%" << "%#{keyword}%"
        end
        query << ' order by tmp.channel_score asc, tmp.article_score asc, articles.updated_at desc limit 100;'
        @articles = execsql(query, query_params)

        unless @channel.tags.blank?
            @tags = @channel.tags.split(',')
            tag = @tags[rand(@tags.length)]
            query = 'select id, title from channels where id <> ? and (title like ? or tags like ?) limit 5;'
            query = ActiveRecord::Base.send :sanitize_sql, [query, @channel.id, "%#{tag}%", "%#{tag}%"]
            @recomends = ActiveRecord::Base.connection.execute(query)
        end
    end

    def create
        p = params[:channel]
        @channel = Channel.new(title: p[:title], description: p[:description],
            tags: p[:tags], user_id: current_user.id, ctype: 'Article', plus: 0,
           minus: 0, visible: p[:visible])
        if @channel.save
            saveTags(@channel.id, '', @channel.tags)
            redirect_to channel_path(@channel)
        end
    end

    def edit
        @channel = Channel.find params[:id]
    end

    def update
        @channel = Channel.find params[:id]
        tags = @channel.tags
        if @channel.update_attributes(params.require(:channel).
                permit(:title, :description, :tags))
            saveTags(@channel.id, tags, params[:channel][:tags])
            redirect_to channel_path(@channel)
        end
    end

    private

    def saveTags(id, old_tags, tags)
        return if old_tags == tags

        sql = 'delete from channel_tags where channel_id = ?;'
        params = [id]
        unless tags.blank?
            tags.split(',').each do |t|
                sql << 'insert into channel_tags(channel_id, tag, score) values(?, ?, ?);'
                params << id << t << 1
            end
        end
        execsql(sql, params)
    end
end

class ArticlesController < ApplicationController
    def index
        @channel = Channel.find(params[:channel_id])
        # 私有频道内容仅允许自己查看
        if @channel.visible == 1 && !current_user?(@channel.user_id)
            redirect_to root_path
            return
        end

        query = 'SELECT c.id, c.title, c.user_id, c.tags, c.content, c.updated_at, u.name, c.visible
FROM "articles" as c left join "users" as u on c.user_id = u.id
where c.channel_id = ? '
        query_params = [@channel.id]
        if @channel.visible == 1
            query << ' and c.user_id = ?'
            query_params << current_user.id
        end
        keyword = params[:keyword]
        unless keyword.blank?
            query << ' and (c.title like ? or c.tags like ?)'
            query_params << "%#{keyword}%" << "%#{keyword}%"
        end
        query << ' order by c.updated_at desc limit 100;'
        @articles = execsql(query, query_params)

        unless @channel.tags.blank?
            @tags = @channel.tags.split(',')
            tag = @tags[rand(@tags.length)]
            query = 'select id, title from channels where id <> ? and (title like ? or tags like ?) limit 5;'
            query = ActiveRecord::Base.send :sanitize_sql, [query, @channel.id, "%#{tag}%", "%#{tag}%"]
            @recomends = ActiveRecord::Base.connection.execute(query)
        end
    end

    def new
        unless signed_in?
            redirect_to root_path
            return
        end
        @channel = Channel.find(params[:channel_id])
        @article = Article.new(channel_id: params[:channel_id])
    end

    def show
        @article = Article.find(params[:id])
        # 私有文章不允许他人查看
        if @article.visible == 2 && !current_user?(@article.user_id)
            redirect_to root_path
            return
        end

        unless @article.tags.blank?
            @tags = @article.tags.split(',')
            tag = @tags[rand(@tags.length)]
            query = 'select id, title from articles where id <> ? and (title like ? or tags like ?) limit 5;'
            query = ActiveRecord::Base.send :sanitize_sql, [query, @article.id, "%#{tag}%", "%#{tag}%"]
            @recomends = ActiveRecord::Base.connection.execute(query)
        end
    end

    def create
        unless signed_in?
            redirect_to root_path
            return
        end
        p = params[:article]
        @article = Article.new title: p[:title], content: p[:content], tags: p[:tags],
            user_id: current_user.id, channel_id: params[:channel_id], visible: p[:visible]

        if @article.save
            redirect_to request.path + '/' + @article.id.to_s
        else
            render 'new'
        end
    end

    def edit
        unless signed_in?
            redirect_to root_path
            return
        end
        @article = Article.find(params[:id])
        unless current_user?(@article.user_id)
            redirect_to root_path
            return
        end

        @channel = Channel.find(params[:channel_id])
    end

    def update
        unless signed_in?
            redirect_to root_path
            return
        end
        article = Article.find params[:id]
        unless current_user?(article.user_id)
            redirect_to root_path
            return
        end

        if article.update_attributes(params.require(:article).permit(:title, :content, :tags, :visible))
            redirect_to request.path
        end
    end

    def destroy
    end
end

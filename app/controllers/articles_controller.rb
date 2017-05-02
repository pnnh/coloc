class ArticlesController < ApplicationController
    def index
        @channel = Channel.find(params[:channel_id])

        keyword = params[:keyword]
        query = 'SELECT c.id, c.title, c.user_id, c.tags, c.content, c.updated_at, u.name
FROM "articles" as c left join "users" as u on c.user_id = u.id where c.channel_id = ? '
        query_params = [query, @channel.id]
        unless keyword.blank?
            query += ' and (c.title like ? or c.tags like ?)'
            query_params = [query, @channel.id, "%#{keyword}%", "%#{keyword}%"]
        end
        query += ' order by c.updated_at desc limit 100;'
        query_params[0] = query
        query = ActiveRecord::Base.send :sanitize_sql, query_params
        @articles = ActiveRecord::Base.connection.execute(query)

        unless @channel.tags.blank?
            @tags = @channel.tags.split(',')
            tag = @tags[rand(@tags.length)]
            query = 'select id, title from channels where id <> ? and (title like ? or tags like ?) limit 5;'
            query = ActiveRecord::Base.send :sanitize_sql, [query, @channel.id, "%#{tag}%", "%#{tag}%"]
            @recomends = ActiveRecord::Base.connection.execute(query)
        end
    end

    def new
        @article = Article.new(channel_id: params[:channel_id])
    end

    def show
        @article = Article.find(params[:id])

        unless @article.tags.blank?
            @tags = @article.tags.split(',')
            tag = @tags[rand(@tags.length)]
            query = 'select id, title from articles where id <> ? and channel_id = ? and (title like ? or tags like ?) limit 5;'
            query = ActiveRecord::Base.send :sanitize_sql, [query, @article.id, @article.channel_id, "%#{tag}%", "%#{tag}%"]
            @recomends = ActiveRecord::Base.connection.execute(query)
        end
    end

    def create
        p = params[:article]
        @article = Article.new title: p[:title], content: p[:content], tags: p[:tags],
            user_id: current_user.id, channel_id: params[:channel_id]

        if @article.save
            redirect_to request.path + '/' + @article.id.to_s
        else
            render 'new'
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        article = Article.find params[:id]
        if article.update_attributes(params.require(:article).permit(:title, :content, :tags))
            redirect_to request.path
        end
    end

    def destroy
    end
end

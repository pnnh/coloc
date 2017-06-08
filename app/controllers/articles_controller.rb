class ArticlesController < ApplicationController
    before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]

    def index
        query = 'SELECT c.id, c.title, c.user_id, c.tags, c.content, c.updated_at, c.visible
FROM "articles" as c where c.user_id = ? '
        query_params = [current_user.id]
        keyword = params[:keyword]
        unless keyword.blank?
            query << ' and (c.title like ? or c.tags like ?)'
            query_params << "%#{keyword}%" << "%#{keyword}%"
        end
        query << ' order by c.updated_at desc limit 100;'
        @articles = execsql(query, query_params)

        @tags = []
        @articles.each do |c|
            unless c['tags'].blank?
                @tags |= c['tags'].split(',')
            end
        end
    end

    def new
        @article = Article.new
        store_location
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
        store_location
    end

    def create
        p = params[:article]
        @article = Article.new title: p[:title], content: p[:content], tags: p[:tags],
            user_id: current_user.id, visible: p[:visible], copyright: p[:copyright]

        if @article.save
            saveTags(@article.id, '', @article.tags)
            redirect_to article_path(@article)
        end
    end

    def edit
        @article = Article.find(params[:id])
        unless current_user?(@article.user_id)
            redirect_to root_path
            return
        end
    end

    def update
        article = Article.find params[:id]
        unless current_user?(article.user_id)
            redirect_to root_path
            return
        end
        tags = article.tags
        ctype = params[:article][:ctype]
        ctype = 'md' if ctype.blank? || ctype != 'html'
        props = params.require(:article).permit(:title, :content, :tags, :visible, :copyright)
        props[:ctype] = ctype if ctype != article.ctype

        if article.update_attributes(props)
            saveTags(article.id, tags, params[:article][:tags])
            redirect_to article_path(article)
        end
    end

    def destroy
    end

    private

    def saveTags(id, old_tags, tags)
        return if old_tags == tags

        sql = 'delete from article_tags where article_id = ?;'
        params = [id]
        unless tags.blank?
            tags.split(',').each do |t|
                sql << 'insert into article_tags(article_id, tag, score) values(?, ?, ?);'
                params << id << t << 1
            end
        end
        execsql(sql, params)
    end

    def signed_in_user
        unless signed_in?
            redirect_to root_path
        end
    end
end

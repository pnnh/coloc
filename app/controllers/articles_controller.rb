class ArticlesController < ApplicationController
    def index
        @channel = Channel.find(params[:channel_id])

        keyword = params[:keyword]
        if !keyword.nil? && !keyword.blank? and keyword.length > 1
            @articles = @channel.articles.where('title ~* ? or tags ~* ?', keyword, keyword).limit(100)
        else
            @articles = @channel.articles.all.limit(100)
        end
    end

    def new
        @article = Article.new(channel_id: params[:channel_id])
    end

    def show
        @article = Article.find(params[:id])
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

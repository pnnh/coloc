class ArticlesController < ApplicationController
    def index
        @channel = Channel.find(params[:channel_id])

        keyword = params[:keyword]
        if !keyword.nil? && !keyword.blank? and keyword.length > 1
            @articles = @channel.articles.where('title like ? or tags like ?', "%#{keyword}%", "%#{keyword}%").limit(100)
        else
            @articles = @channel.articles.all.limit(100)
        end
    end

    def new
        @article = Article.new
    end

    def show
        @article = Article.find(params[:id])
    end

    def create
        article = Article.new title: params[:article][:title],
                              content: params[:article][:content],
                              user: current_user
        content = Content.new entity: article,
                              channel_id: params[:channel_id],
                              user: current_user

        if article.save && content.save
            redirect_to channel_article_path(params[:channel_id], article)
        end
    end

    def edit
        @article = Article.find(params[:id])
        @content = @article.content
    end

    def update
        article = Article.find params[:id]
        if article.update_attributes(params.require(:article).permit(:title, :content))
            redirect_to request.path
        end
    end

    def destroy
    end
end

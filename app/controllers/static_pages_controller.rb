class StaticPagesController < ApplicationController
    def index
        @slogan = Slogan.offset(rand(Slogan.count)).first
        if @slogan.nil?
            @slogan = Slogan.new(words:'欢迎，请在上方搜索内容')
        end
    end

    def help
    end

    def about
    end

    def contact
    end
end

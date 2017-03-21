class StaticPagesController < ApplicationController
    def index
        @slogan = Slogan.offset(rand(Slogan.count)).first
    end

    def help
    end

    def about
    end

    def contact
    end
end

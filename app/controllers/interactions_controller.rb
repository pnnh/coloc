class InteractionsController < ApplicationController
    before_action :signed_in_user

    def new
    end

    def index
        @interactions = Channel.joins(:interaction).where(interactions:{user_id: current_user.id})
    end

    def show
    end

    def create
    end

    def edit
    end

    def update
    end

    private

    # Before filters

    def signed_in_user
        unless signed_in?
            store_location
            redirect_to signin_url, notice: 'Please sign in.'
        end
    end
end

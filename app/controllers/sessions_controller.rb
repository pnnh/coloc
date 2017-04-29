class SessionsController < ApplicationController
    def new
    end

    def create
        unless verify_rucaptcha?
            redirect_to signin_path
            return
        end
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            sign_in user
            redirect_back_or channel_follows_path
        else
            redirect_to signin_path
        end
    end

    def destroy
        sign_out
        redirect_to root_path
    end
end

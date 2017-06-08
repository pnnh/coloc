module SessionsHelper
    def sign_in(user)
        remember_token = User.new_remember_token
        cookies.permanent[:remember_token] = remember_token
        user.update_attribute(:remember_token, User.encrypt(remember_token))
        self.current_user = user
    end

    def signed_in?
        !current_user.nil?
    end

    def current_user=(user)
        @current_user = user
    end

    def current_user
        remember_token = cookies[:remember_token]
        if !remember_token.nil? && !remember_token.blank?
            @current_user ||= User.find_by(remember_token: User.encrypt(remember_token))
        end
    end

    def current_user?(user)
        !current_user.nil? && (user == current_user || user == current_user.id)
    end

    def sign_out
        self.current_user = nil
        cookies.delete(:remember_token)
    end

    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end

    def retrive_location
        @return_to ||= session[:return_to]
    end

    def store_location
        session[:return_to] = params[:return_to] || session[:return_to]
    end
end

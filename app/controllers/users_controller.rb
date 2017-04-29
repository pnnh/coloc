class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def show
    id = params[:id]
    if(id.to_i > 0)
      @user = User.find id
    elsif(!id.blank?)
      @user = User.friendly.find id rescue nil
      if(@user.nil?)
        @keyword = id
        @users = User.where("name LIKE :q", q: "%#{@keyword}%").limit(100)
        render 'index'
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    unless verify_rucaptcha?
      redirect_to new_user_path
      return
    end
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    user_params = params.require(:user).permit(:name, :password, :password_confirmation)
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  private
  
    # Before filters
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: 'Please sign in.'
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end

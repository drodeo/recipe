class ProfilesController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :require_login

  def show
   #  @recipes = Recipe.order('created_at DESC').page(params[:page]).per(10)
  end

  def edit
  end

  def index
   #  @recipes = Recipe.order('created_at DESC').page(params[:page]).per(10)
   
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :phone, :avatar)
  end

  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end
end

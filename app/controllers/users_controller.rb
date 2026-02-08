class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(profile_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to profile_user_path
    else
      render "edit_profile", status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :introduction, :icon)
  end
end

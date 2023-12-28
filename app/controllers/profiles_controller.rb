class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params, context: :account_setup)
      redirect_to root_path, notice: 'Your profile has been updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :mattermost_id)
  end
end

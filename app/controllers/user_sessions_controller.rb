class UserSessionsController < ApplicationController
  skip_after_action :verify_authorized

  def destroy
    logout
    redirect_to root_url, notice: 'ログアウトしました'
  end
end

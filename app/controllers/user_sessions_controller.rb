class UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to root_url, notice: 'ログアウトしました'
  end
end

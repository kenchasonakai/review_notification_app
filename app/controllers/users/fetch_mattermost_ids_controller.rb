module Users
  class FetchMattermostIdsController < ApplicationController
    require 'mattermost'
    skip_after_action :verify_authorized

    def create
      @user = User.find(current_user.id)
      uri = URI.parse('https://chat.runteq.jp')
      client = Mattermost.new_client(uri)
      client.login(params[:email], params[:password])
      username = client.get_me['username']
      @user.update(mattermost_id: username) if username.present?
    end
  end
end

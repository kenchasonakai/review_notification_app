module Notification
  class Mattermost < Notification::Base
    attr_reader :notification_type, :message, :mattermost_channel

    def initialize(**args)
      super
      @mattermost_channel = args[:mattermost_channel]
    end

    private

    def send_mattermost
      uri = URI.parse(Settings.mattermost.webhook_url)
      header = { 'Content-Type': 'application/json' }
      data = { text: message,
               channel: mattermost_channel,
               username: 'farao_sub',
               icon_emoji: ':nisemonorantekun:' }.to_json
      response = Net::HTTP.post(uri, data, header)
      response.code == '200'
    end
  end
end

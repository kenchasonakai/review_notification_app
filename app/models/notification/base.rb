module Notification
  class Base
    attr_reader :notification_type, :message

    def call
      send("send_#{notification_type}")
    rescue NoMethodError
      raise NotImplementedError, "notification_type: #{notification_type} is not implemented"
    end

    def initialize(**args)
      @notification_type = self.class.name.demodulize.underscore
      @message = args[:message]
    end
  end
end

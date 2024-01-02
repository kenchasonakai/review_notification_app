class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[home]
  skip_after_action :verify_authorized

  def home; end
end

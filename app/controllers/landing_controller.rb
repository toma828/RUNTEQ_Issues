class LandingController < ApplicationController
  skip_before_action :require_login
  layout 'landing'

  def index
    # アクションの内容
  end
end
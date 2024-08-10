class ApplicationController < ActionController::Base    
  before_action :require_login

  private

  def not_authenticated
    redirect_to main_app.new_session_url, alert: "まずは魔法の書にログインしてください。"
  end


end

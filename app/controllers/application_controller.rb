class ApplicationController < ActionController::Base    
  before_action :require_login

  private

  def not_authenticated
    redirect_to new_session_path, alert: "まずは魔法の書にログインしてください。"
  end
end

class ApplicationController < ActionController::Base    
  private

  def not_authenticated
    redirect_to login_path, alert: "まずは魔法の書にログインしてください。"
  end
end

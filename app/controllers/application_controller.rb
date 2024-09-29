class ApplicationController < ActionController::Base    
  before_action :require_login

  private

  def not_authenticated
    redirect_to new_session_path, alert: "まずは魔法の書にログインしてください。"
  end
  
  class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_url, alert: 'アクセスが拒否されました。'
    end
  end
end

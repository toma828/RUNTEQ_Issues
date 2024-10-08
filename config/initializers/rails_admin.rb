# frozen_string_literal: true

RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  # Use the current_user method to check the current user
  config.current_user_method(&:current_user)

  # Authorization with CancanCan
  config.authorize_with :cancancan

  # Set the parent controller to ApplicationController
  config.parent_controller = '::ApplicationController'

  # Redirect non-admin users and set flash message
  config.authorize_with do
    unless current_user.admin?
      flash[:alert] = 'アクセス権限がありません。'
      redirect_to main_app.top_path
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

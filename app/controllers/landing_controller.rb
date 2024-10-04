# frozen_string_literal: true

# サイト開く時の読み込みページ
class LandingController < ApplicationController
  skip_before_action :require_login
  layout 'landing'

  def index; end
end

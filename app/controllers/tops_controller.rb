# frozen_string_literal: true

# ページTOP
class TopsController < ApplicationController
  skip_before_action :require_login
  def index; end
end

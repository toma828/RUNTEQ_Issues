# frozen_string_literal: true

# ラインログイン
class Authentication < ApplicationRecord
  belongs_to :user
end

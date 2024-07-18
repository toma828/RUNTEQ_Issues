class Diary < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
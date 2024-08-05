class Diary < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :content, presence: true
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
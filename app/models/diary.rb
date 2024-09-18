class Diary < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  after_create :generate_chatgpt_response
  after_create_commit :update_user_special_characters

  validates :content, presence: true
  validates :date, presence: true, uniqueness: { scope: :user_id }

  private

  def generate_chatgpt_response
    ChatgptResponseJob.perform_later(id)
  end

  def update_user_special_characters
    special_characters = []
    content.scan(/猫|本|魔法|楽しい|友達/) do |match|
      special_characters << match
    end
    user.update(special_characters: (user.special_characters.to_s.split(',') + special_characters).uniq.join(','))
  end
end
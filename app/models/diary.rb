class Diary < ApplicationRecord
  belongs_to :user
  after_create :generate_chatgpt_response

  validates :content, presence: true
  validates :date, presence: true, uniqueness: { scope: :user_id }

  private

  def generate_chatgpt_response
    ChatgptResponseJob.perform_later(id)
  end
end
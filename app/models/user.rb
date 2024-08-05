class User < ApplicationRecord
  authenticates_with_sorcery!
  before_create :setup_activation
  has_many :diaries

  validates :name, presence: true, length: { maximum: 50, allow_blank: true}
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  def setup_activation
    self.activation_token = SecureRandom.urlsafe_base64
    self.activation_state = 'pending'
  end
end

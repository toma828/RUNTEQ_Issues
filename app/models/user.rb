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

  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def setup_activation
    self.activation_token = SecureRandom.urlsafe_base64
    self.activation_state = 'pending'
  end

  def deliver_reset_password_instructions!
    # パスワードリセットのメール送信ロジックを実装
    reset_password_email_sent_at = Time.now
    generate_reset_password_token!
    UserMailer.reset_password_email(self).deliver_now
  end

  def special_character_list
    special_characters.to_s.split(',')
  end
end

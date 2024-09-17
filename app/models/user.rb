class User < ApplicationRecord
  authenticates_with_sorcery!
  before_create :setup_activation, unless: :line_login
  has_many :diaries
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, unless: :line_login
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :line_uid, uniqueness: true, allow_nil: true

  def setup_activation
    return if line_login
    self.activation_token = SecureRandom.urlsafe_base64
    self.activation_state = 'pending'
  end

  def deliver_reset_password_instructions!
    reset_password_email_sent_at = Time.now
    generate_reset_password_token!
    UserMailer.reset_password_email(self).deliver_now
  end

  def special_character_list
    special_characters.to_s.split(',')
  end

  def send_activation_email
    UserMailer.activation_needed_email(self).deliver_now unless line_login
  end

  def activate!
    if line_login
      update_column(:activation_state, 'active')
    else
      super
    end
  end

  def active?
    line_login || super
  end

  def line_login
    authentications.exists?(provider: 'line')
  end

  def line_login=(value)
    @line_login = value
  end
end
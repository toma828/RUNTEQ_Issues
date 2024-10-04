# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  trait :pending do
    activation_state { 'pending' }
  end

  trait :active do
    # アクティブな状態にするための設定
    activation_state { 'active' }
    
    after(:create) do |user|
      # メールを送信して、ユーザーをアクティブにする処理
      user.send_activation_email
      user.activate!
    end
  end
end

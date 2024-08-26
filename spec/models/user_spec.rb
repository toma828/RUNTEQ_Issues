require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効な属性であればユーザーは有効です" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名前がないとユーザーは無効です" do
    user = FactoryBot.build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it "メールアドレスがないとユーザーは無効です" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "重複するメールアドレスがあるとユーザーは無効です" do
    FactoryBot.create(:user, email: "test@example.com")
    user = FactoryBot.build(:user, email: "test@example.com")
    expect(user).not_to be_valid
  end

  it "パスワードがないとユーザーは無効です" do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "パスワードと確認パスワードが一致しないとユーザーは無効です" do
    user = FactoryBot.build(:user, password_confirmation: "mismatch")
    expect(user).not_to be_valid
  end
end
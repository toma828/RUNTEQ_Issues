require 'rails_helper'

RSpec.describe "ユーザー管理", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it "ユーザーが正常にサインアップできる" do
    visit new_session_path # サインアップページへのパスをカスタムに合わせる
    fill_in "Name", with: "Test User"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content("Welcome") # 適切なメッセージを確認
  end

  it "ユーザーが正常にログインできる" do
    visit new_session_path # ログインページへのパスをカスタムに合わせる
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.") # 適切なメッセージを確認
  end

  it "ユーザーが正常にログアウトできる" do
    login_as(user) # ユーザーをログインさせるためのヘルパー（後述）
    visit root_path # ログアウト用リンクを含むページへ移動
    click_link "Logout"
    expect(page).to have_content("Signed out successfully.") # 適切なメッセージを確認
  end
end
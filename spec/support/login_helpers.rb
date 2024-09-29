module LoginHelpers
  def login_as(user)
    visit new_session_path
    fill_in "魔法の通信アドレス", with: user.email
    fill_in "秘密の呪文", with: 'password'
    click_button "魔法の書を開く"
  end
end
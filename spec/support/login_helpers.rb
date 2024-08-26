module LoginHelpers
  def login_as(user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
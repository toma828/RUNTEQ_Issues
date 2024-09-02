require 'rails_helper'

RSpec.describe "ユーザー登録", type: :system do

  context '入力情報が正しい場合' do
    it 'ユーザーが新規作成できること' do
      visit new_user_path
      expect {
        fill_in "契約者の名前", with: "Test User"
        fill_in "魔法の通信アドレス", with: "test@example.com"
        fill_in "秘密の呪文", with: "password"
        fill_in "秘密の呪文（確認）", with: "password"
        find("input[type='checkbox'][name='user[terms_accepted]']").click

        click_button "魔法の書を受け取る"
        Capybara.assert_current_path("/top", ignore_query: true)
      }.to change { User.count }.by(1)
      expect(page).to have_content('確認メールを送信しました。メールを確認して登録を完了してください。'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'

      # ユーザーが作成されているか確認
      user = User.find_by(email: 'test@example.com')
      expect(user).not_to be_nil
      expect(user.activation_state).to eq('pending')
    end

    it "ユーザーが正常にメール認証できる" do
      user = create(:user, :pending)
      # メール送信メソッドを呼び出す
      user.send_activation_email 
  
      # メールが送信されたことを確認するために、ユーザーがアクティベートされるリンクにアクセス
      visit activate_user_path(user.activation_token)
  
      expect(page).to have_content('メールアドレスが確認され、魔法の書の主人として認められました！')
      expect(user.reload.activation_state).to eq('active')
    end
  end

  context '入力情報が異常な場合' do
    it 'ユーザーが新規作成できない' do
      visit new_user_path
      expect {
        fill_in '魔法の通信アドレス', with: 'test@example.com'
        click_button '魔法の書を受け取る'
      }.to change { User.count }.by(0)
      expect(page).to have_content('名前を入力してください'), 'フラッシュメッセージ「名前を入力してください」が表示されていません'
      expect(page).to have_content('秘密の呪文は3文字以上で入力してください'), 'フラッシュメッセージ「秘密の呪文は3文字以上で入力してください」が表示されていません'
    end
  end
  
end
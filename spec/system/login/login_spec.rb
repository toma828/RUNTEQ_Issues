# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  let(:user) { create(:user, :active) } # アクティブなユーザーを作成

  describe 'ログイン' do
    context '認証情報が正しい場合' do
      it 'ユーザーが正常にログインできる' do
        login_as_user(user)
        expect(page).to have_content('ログインしました')
      end
    end

    context '認証情報が誤っている場合' do
      it 'ログインできないこと' do
        visit new_session_path
        fill_in '魔法の通信アドレス', with: user.email
        fill_in '秘密の呪文', with: 'passwordooo'
        click_button '魔法の書を開く'

        expect_login_failure
      end
    end
  end

  describe 'ログアウト' do
    before { login_as(user) }

    it 'ユーザーが正常にログアウトできる' do
      visit top_path # ログアウト用リンクを含むページへ移動
      click_link '本を閉じる'
      expect(page).to have_content('魔法の書を閉じました。') # 適切なメッセージを確認
    end
  end

  private

  def login_as_user(user)
    visit new_session_path
    fill_in '魔法の通信アドレス', with: user.email
    fill_in '秘密の呪文', with: 'password'
    click_button '魔法の書を開く'
  end

  def expect_login_failure
    expect(current_path).to eq(new_session_path), 'ログイン失敗時にログイン画面に戻ってきていません'
    expect(page).to have_content('魔法の通信アドレスまたは秘密の呪文が間違っています。'), 'フラッシュメッセージ「魔法の通信アドレスまたは秘密の呪文が間違っています。」が表示されていません'
  end
end

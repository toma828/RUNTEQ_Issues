# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '日記', type: :system do
  let(:user) { create(:user, :active) }

  describe '日記投稿' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        check_redirect_to_login
      end
    end

    context 'ログインしている場合' do
      before do
        login_as(user)
        click_on('今日の日記')
      end

      context '入力情報が正常な場合' do
        it '日記が投稿できること' do
          fill_in 'diary_content', with: '日記内容本文<テスト>'
          click_button 'アルディアスに送る'
          expect(page).to have_content('日記が作成されました。')
          expect(page).to have_content('おお、急がば回れじゃ。しばし待たれよ。')
        end
      end

      context '入力情報が異常な場合' do
        it '日記が投稿できないこと' do
          click_button 'アルディアスに送る'
          expect(page).to have_content('内容を入力してください')
        end
      end
    end
  end

  describe '日記更新' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        check_redirect_to_login
      end
    end

    context 'ログインしている場合' do
      before do
        login_as(user)
        create(:diary, user)
        visit diaries_path(Date.today)
        click_link '日記を見る'
      end

      context '入力情報が正常な場合' do
        it '日記が編集できること' do
          click_link '編集'
          fill_in 'diary_content', with: '日記内容編集後本文<テスト>'
          click_button '更新'
          expect(page).to have_content('日記が更新されました')
        end
      end

      context '入力情報が異常な場合' do
        it '日記が編集できないこと' do
          click_link '編集'
          fill_in 'diary_content', with: ''
          click_button '更新'
          expect(page).to have_content('内容を入力してください')
        end
      end
    end
  end

  private

  def check_redirect_to_login
    visit new_session_path
    click_on('今日の日記')
    expect(current_path).to eq(new_session_path)
    expect(page).to have_content('まずは魔法の書にログインしてください。')
  end
end

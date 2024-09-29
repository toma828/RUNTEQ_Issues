require 'rails_helper'

RSpec.describe "日記", type: :system do

    describe "日記投稿" do
        context 'ログインしていない場合' do
            it 'ログインページにリダイレクトされること' do
                visit new_session_path
                click_on('今日の日記')
                Capybara.assert_current_path(new_session_path, ignore_query: true)
                expect(current_path).to eq(new_session_path), 'ログインしていない場合、掲示板作成画面にアクセスした際に、ログインページにリダイレクトされていません'
                expect(page).to have_content('まずは魔法の書にログインしてください。'), 'フラッシュメッセージ「まずは魔法の書にログインしてください。」が表示されていません'
            end
        end

        context 'ログインしている場合' do
            before do 
                user = create(:user, :active)
                login_as(user)
                click_on('今日の日記')
            end

            context '入力情報が正常な場合' do
                it '日記が投稿できること' do
                    fill_in 'diary_content', with: '日記内容本文<テスト>'
                    click_button 'アルディアスに送る'
                    expect(page).to have_content('日記が作成されました。'), 'フラッシュメッセージ「日記が作成されました。」が表示されていません'
                    expect(page).to have_content('おお、急がば回れじゃ。しばし待たれよ。'), '作成した日記の返信待ちページが表示されていません'
                end
            
            end

            context '入力情報が異常な場合' do
                it '日記が投稿できるないこと' do
                    click_button 'アルディアスに送る'
                    expect(page).to have_content('内容を入力してください'), 'フラッシュメッセージ「内容を入力してください」が表示されていません'
                end
            end
        end
    end

    describe "日記更新" do
        context 'ログインしていない場合' do
            it 'ログインページにリダイレクトされること' do
                visit new_session_path
                click_on('今日の日記')
                Capybara.assert_current_path(new_session_path, ignore_query: true)
                expect(current_path).to eq(new_session_path), 'ログインしていない場合、掲示板作成画面にアクセスした際に、ログインページにリダイレクトされていません'
                expect(page).to have_content('まずは魔法の書にログインしてください。'), 'フラッシュメッセージ「まずは魔法の書にログインしてください。」が表示されていません'
            end
        end
        context 'ログインしている場合' do
            before do
                # ユーザーと日記を作成
                user = create(:user, :active)
                login_as(user)
                diary = create(:diary,user: user)
                visit diaries_path(Date.today)
                click_link '日記を見る'
            end
            context '入力情報が正常な場合' do
                it '日記が編集できること' do
                    click_link '編集'
                    fill_in 'diary_content', with: '日記内容編集後本文<テスト>'
                    click_button '更新'
                    expect(page).to have_content('日記が更新されました'), 'フラッシュメッセージ「日記が更新されました」が表示されていません'
                end
            
            end
            context '入力情報が異常な場合' do
                it '日記が編集できないこと' do
                    click_link '編集'
                    fill_in 'diary_content', with: ''
                    click_button '更新'
                end
            end
        end
    end
end
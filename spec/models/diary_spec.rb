require 'rails_helper'

RSpec.describe Diary, type: :model do
    context '全てのフィールドが有効な場合' do
        it '有効であること' do
            diary = build(:diary)
            expect(diary).to be_valid
        end
    end

    context '本文が存在しない場合' do
        it '無効であること' do
            diary = build(:diary, content: nil)
            expect(diary).to be_invalid
            expect(diary.errors[:content]).to include('を入力してください')
        end
    end

end
# frozen_string_literal: true

namespace :users do
  desc 'Update special_characters for existing users'
  task update_special_characters: :environment do
    User.find_each do |user|
      special_chars = user.diaries.flat_map do |diary|
        diary.content.scan(/悲しい|嬉しい|たまご|ラーメン|杖/)
      end
      
      # special_charsを使用した処理がここに入ります
      # 例: user.update(special_character_list: special_chars)

    end
  end
end

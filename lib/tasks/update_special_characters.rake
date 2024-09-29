namespace :users do
  desc "Update special_characters for existing users"
  task update_special_characters: :environment do
    User.find_each do |user|
    special_chars = user.diaries.flat_map do |diary|
        diary.content.scan(/悲しい|嬉しい|たまご|ラーメン|杖/)
    end.uniq
    user.update(special_characters: special_chars.join(','))
    end
  end
end
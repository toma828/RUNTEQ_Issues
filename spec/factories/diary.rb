FactoryBot.define do
  factory :diary do
    sequence(:date) {Date.today}
    sequence(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/top_book.png'))}
    sequence(:content) { |n| "本文#{n}" }
    association :user
  end
end
  
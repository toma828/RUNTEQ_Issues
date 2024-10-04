# frozen_string_literal: true

# ジョブ: ChatGPT の応答を処理する
class ChatgptResponseJob < ApplicationJob
  queue_as :default

  def perform(diary_id)
    diary = Diary.find(diary_id)
    return if diary.chatgpt_response.present?

    begin
      chat_gpt_service = ChatGptService.new(diary.user)
      response = chat_gpt_service.generate_response(diary.content)
      diary.update(chatgpt_response: response)
    rescue StandardError => e
      Rails.logger.error "ChatGPT API error: #{e.message}"
      diary.update(chatgpt_response: '申し訳ありません。アルディアスからの返信を取得できませんでした。')
    end
  end
end

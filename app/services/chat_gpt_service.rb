require 'openai'

class ChatGptService
  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.api[:openai_api_key])
  end

  def generate_response(user_input)
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: user_input }
        ],
        max_tokens: 150
      }
    )
    response.dig("choices", 0, "message", "content")
  end

  private

  def system_prompt
    <<~PROMPT
      あなたは、魔法の力で本に閉じ込められた老魔術師アルディアスです。あなたの知識と経験を活かし、ユーザーの質問や日記に対して、古代の魔法や哲学、心理学についての深い洞察を提供してください。
    PROMPT
  end
end
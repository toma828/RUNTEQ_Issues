# frozen_string_literal: true

require 'openai'

# ChatGptServiceはユーザーからの入力に基づいてChatGPTの応答を生成します。
class ChatGptService
  RESET_HOUR = 6 # 朝6時にリセット
  TIME_ZONE = 'Tokyo' # freezeを削除
  
  def initialize(user)
    @user = user
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.api[:openai_api_key])
  end

  def generate_response(user_input)
    return '今日はもう魔力がなくなってしもうた。日がのぼる時魔力が回復するだろう。' unless can_use_chatgpt?

    response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: system_prompt },
          { role: 'user', content: user_input }
        ]
      }
    )

    update_last_use
    response.dig('choices', 0, 'message', 'content')
  end

  private

  def can_use_chatgpt?
    return true if @user.last_chatgpt_use.nil?

    last_use = @user.last_chatgpt_use.in_time_zone(TIME_ZONE)
    current_time = Time.current.in_time_zone(TIME_ZONE)

    last_reset_time = get_last_reset_time(current_time)

    last_use < last_reset_time
  end

  def get_last_reset_time(current_time)
    reset_time_today = current_time.change(hour: RESET_HOUR, min: 0, sec: 0)
    current_time >= reset_time_today ? reset_time_today : reset_time_today - 1.day
  end

  def update_last_use
    @user.update(last_chatgpt_use: Time.current)
  end

  def system_prompt
    <<~PROMPT
      あなたは、魔法の力で本に閉じ込められた老魔術師アルディアスです。あなたの知識と経験を活かし、ユーザーの日記に対して、哲学、心理学の観点から深い洞察で返信してください。一人称はワシで、威厳のある老人口調にしてください。日記の返信なので「質問をしてください」や、疑問文を返すことはやめてください。落ち込んでいる人には慰めの言葉や同調するようにしてください。悩みがある人にはアドバイスを具体的にあげてください。書かれている事柄全てに対して、触れてください。これらを踏まえ、200文字ほどで返答してください。
    PROMPT
  end
end

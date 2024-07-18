class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy, :chatgpt_response]

  def index
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_week
    @end_date = @start_date.end_of_week
    @diaries = current_user.diaries.where(date: @start_date..@end_date).index_by(&:date)
  end

  def show
    @chatgpt_response = @diary.chatgpt_response
  end

  def new
    @diary = current_user.diaries.build(date: params[:date])
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to chatgpt_response_diary_path(@diary), notice: '日記が作成されました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: '日記が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: '日記が削除されました。'
  end

  def chatgpt_response
    @chatgpt_response = generate_chatgpt_response(@diary)
    @diary.update(chatgpt_response: @chatgpt_response)
  end

  private

  def generate_chatgpt_response(diary)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # または適切なモデルを指定
        messages: [
          { role: "system", content: "あなたはアルディアスという名前の老魔法使いです。ユーザーの日記に対して、魔法使いらしい言葉遣いで温かくアドバイスをしてください。" },
          { role: "user", content: diary.content }
        ],
        temperature: 0.7,
      }
    )
    response.dig("choices", 0, "message", "content")
  rescue => e
    Rails.logger.error "ChatGPT API error: #{e.message}"
    "申し訳ありません。アルディアスからの返信を取得できませんでした。"
  end

  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:content, :date)
  end
end

class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy, :waiting_for_response, :chatgpt_response]

  def index
    @selected_date = params[:selected_date] ? Date.parse(params[:selected_date]) : Date.today
    @start_date = @selected_date.beginning_of_week(:sunday)
    @end_date = @start_date + 6.days
    @diaries = Diary.where(date: @start_date..@end_date).index_by(&:date)
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
      redirect_to waiting_for_response_diary_path(@diary), notice: '日記が作成されました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @diary.update(diary_params)
      respond_to do |format|
        format.html { redirect_to @diary, notice: '日記が更新されました。' }
        format.json { render json: { success: true, content: @diary.content, image_url: @diary.image.url } }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { success: false, errors: @diary.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: '日記が削除されました。'
  end

  def waiting_for_response
    @diary = current_user.diaries.find(params[:id])
  end

  def check_response
    @diary = current_user.diaries.find(params[:id])
    render json: { response: @diary.chatgpt_response }
  end

  def chatgpt_response
    @chatgpt_response = @diary.chatgpt_response
    if @chatgpt_response.present?
      if @chatgpt_response.start_with?("今日はもう魔力がなくなってしもうた。日がのぼる時魔力が回復するだろう。")
        redirect_to @diary, alert: @chatgpt_response
      else
        redirect_to chatgpt_response, notice: 'アルディアスからの返信が届きました。'
      end
    else
      redirect_to waiting_for_response_diary_path(@diary), notice: 'アルディアスからの返信をまだ待っています。'
    end
  end

  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:content, :date, :image, :image_cache, :remove_image)
  end
end

# frozen_string_literal: true

# ラインbotコントローラー
class LineBotController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      handle_event(event) if event.is_a?(Line::Bot::Event::Message)
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.line[:messaging_channel_secret]
      config.channel_token = Rails.application.credentials.line[:messaging_channel_token]
    end
  end

  def handle_event(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      handle_text_message(event)
    end
  end

  def handle_text_message(event)
    user_id = event['source']['userId']
    text = event.message['text']
    
    Rails.logger.info "Received LINE User ID: #{user_id}"

    return unless text.start_with?('日記:')

    content = text.sub('日記:', '').strip
    user = User.find_by(line_uid: user_id)

    Rails.logger.info "Found user: #{user.inspect}"
    
    reply_text = if user
                   create_diary(user, content)
                 else
                   'ユーザーが見つかりません。アプリでLINE連携を確認してください。'
                 end

    client.reply_message(event['replyToken'], { type: 'text', text: reply_text })
  end

  def create_diary(user, content)
    diary = user.diaries.create(content: content, date: Date.today)
    diary.persisted? ? '日記が投稿されました。' : '日記の投稿に失敗しました。'
  end
end

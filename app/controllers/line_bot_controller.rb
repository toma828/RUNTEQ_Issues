class LineBotController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          handle_text_message(event)
        end
      end
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

  def handle_text_message(event)
    user_id = event['source']['userId']
    text = event.message['text']

    Rails.logger.info "Received LINE User ID: #{user_id}"

    if text.start_with?('日記:')
      content = text.sub('日記:', '').strip
      user = User.find_by(line_uid: user_id)

      Rails.logger.info "Found user: #{user.inspect}"
      
      if user
        diary = user.diaries.create(content: content, date: Date.today)
        if diary.persisted?
          reply_text = "日記が投稿されました。"
        else
          reply_text = "日記の投稿に失敗しました。"
        end
      else
        reply_text = "ユーザーが見つかりません。アプリでLINE連携を確認してください。"
      end

      client.reply_message(event['replyToken'], { type: 'text', text: reply_text })
    end
  end
end
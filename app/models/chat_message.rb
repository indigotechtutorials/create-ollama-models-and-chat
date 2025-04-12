class ChatMessage < ApplicationRecord
  belongs_to :bot
  after_create_commit :broadcast_update_to_bot
  after_update_commit :broadcast_update_to_bot

private
  def broadcast_update_to_bot
    broadcast_update_to(bot, :chat, target: "chat-messages", partial: "bots/chat_message", locals: { bot: self })
  end
end

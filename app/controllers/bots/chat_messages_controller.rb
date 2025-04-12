module Bots
  class ChatMessagesController < ApplicationController
    def create
      @bot = Bot.find(params[:bot_id])
      chat_message = @bot.chat_messages.create(user_prompt: params[:body])
      chat_message.broadcast_update_to(@bot, :chat, target: "chat-form", partial: "bots/chat_form", locals: { bot: @bot })
      BotAiResponseJob.perform_later(chat_message.id)
      head :ok
    end
  end
end
class BotAiResponseJob < ApplicationJob
  queue_as :default

  def perform(chat_message_id)
    chat_message = ChatMessage.find(chat_message_id)
    bot = chat_message.bot

    client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    client.generate(
      { model: bot.ollama_model_name,
        prompt: chat_message.user_prompt }
    ) do |event, raw|
      content = chat_message.ai_response || ""
      content += event["response"]
      chat_message.update(ai_response: content)
    end
  end
end

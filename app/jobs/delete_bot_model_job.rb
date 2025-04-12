class DeleteBotModelJob < ApplicationJob
  queue_as :default

  def perform(bot_ollama_model_name)
    client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    result = client.delete(
      { name: bot_ollama_model_name }
    )
  end
end

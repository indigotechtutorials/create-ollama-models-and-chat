class CreateOllamaModelJob < ApplicationJob
  queue_as :default

  def perform(bot_id)
    @bot = Bot.find(bot_id)
    
    client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    model_data = "#{@bot.description}; Your name is #{@bot.name}"

    result = client.create(
      { model: @bot.ollama_model_name,
        from: 'llama3.2',
        system: model_data }
    ) do |event, raw|
      puts event
    end
  end
end

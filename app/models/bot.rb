class Bot < ApplicationRecord
  has_many :chat_messages, dependent: :destroy
  validates_presence_of :name, :description

  def ollama_model_name
    [name.parameterize, id].join("-")
  end
end

class CreateChatMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_messages do |t|
      t.text :user_prompt
      t.text :ai_response
      t.belongs_to :bot, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class FixChatCountColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :chat_count, :chats_count
  end
end


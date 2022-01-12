class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number , null: false, add_index: true
      t.integer :messages_count ,null: false ,default: 0
      t.references :application, foreign_key: true

      t.timestamps
    end
    add_index :chats, [:application_id, :number], unique: true

  end
end

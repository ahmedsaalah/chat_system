class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name ,null: false
      t.string :token ,null: false , unique: true , add_index: true
      t.integer :chat_count , null: false, default: 0

      t.timestamps
    end
  end
end

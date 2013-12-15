class CreateUsersMessages < ActiveRecord::Migration
  def change
    create_table :users_messages do |t|
      t.integer :user_id
      t.integer :message_id
      t.string :status, default: 'open'

      t.timestamps
    end
    add_index :users_messages, :user_id
    add_index :users_messages, :message_id
  end
end

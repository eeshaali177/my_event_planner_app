class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end
end

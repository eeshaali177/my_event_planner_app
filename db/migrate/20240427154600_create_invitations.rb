class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.integer :event_id

      t.timestamps
    end
  end
end

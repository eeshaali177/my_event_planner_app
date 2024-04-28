class Invitation < ApplicationRecord
    class Invitation < ApplicationRecord
        belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
        belongs_to :event
      
        validates :sender_id, presence: true
        validates :event_id, presence: true
        # Add any additional validations as needed
      
        # Method to check if recipient email is present or if invitee is a registered user
        def recipient_present?
          recipient_email.present? || invitee.present?
        end
      end
      
end

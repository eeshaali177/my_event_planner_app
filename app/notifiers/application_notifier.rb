class ApplicationNotifier < Noticed::Event
    deliver_by :database
  
    # Define notification content
    def message
      "#{event.title}: You have been invited by #{sender_email}!"
    end
  
    # Define notification recipients
    def to_database
      {
        sender_id: sender.id,
        recipient_id: recipient.id,
        event_id: event.id
      }
    end
  
    # Helper method to get inviter's name
    def sender_name
      sender.email # assuming User model has a 'name' attribute
    end
  end

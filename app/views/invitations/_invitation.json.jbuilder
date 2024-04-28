json.extract! invitation, :id, :sender_id, :recipient_email, :event_id, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)

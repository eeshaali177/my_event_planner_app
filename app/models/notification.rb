class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :event
  attribute :status, :integer
  enum status: { pending: 0, accepted: 1, rejected: 2 }, _suffix: true

  def message_content(accept_path, reject_path)
    accept_link = "<a href='#{accept_path}'><button type='button'>Accept</button></a>"
    reject_link = "<a href='#{reject_path}'><button type='button'>Reject</button></a>"

    "You have been invited to the event: #{@event}
    <br>
    #{accept_link}
    #{reject_link}"
  end
end

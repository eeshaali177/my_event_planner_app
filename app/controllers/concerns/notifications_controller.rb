class NotificationsController < ApplicationController
    def accept_invitation
      notification = Notification.find(params[:id])
      notification.update(accepted: true)
      
  
     
      sender_notification = Notification.create(recipient: notification.sender, content: "Your invitation has been accepted.")
     
    end
  
    def reject_invitation
      notification = Notification.find(params[:id])
      notification.update(rejected: true)
    

      sender_notification = Notification.create(recipient: notification.sender, content: "Your invitation has been rejected.")
  
    end
  end
  
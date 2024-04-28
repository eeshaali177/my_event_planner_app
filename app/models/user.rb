class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
  has_many :events
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id'
  has_many :received_invitations, class_name: 'Invitation', foreign_key: 'sender_id'
end

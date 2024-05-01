class Event < ApplicationRecord
  belongs_to :user, class_name: 'User' 
  validates :title, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  has_many :invitations, dependent: :destroy
  has_many :comments
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"
end

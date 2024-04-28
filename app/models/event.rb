class Event < ApplicationRecord
  belongs_to :user, class_name: 'User' # Changed from :users to :user
  validates :title, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  has_many :invitations, dependent: :destroy
end

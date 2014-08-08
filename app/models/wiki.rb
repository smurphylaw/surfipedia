class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true, length: { minimum: 20 }

  
end

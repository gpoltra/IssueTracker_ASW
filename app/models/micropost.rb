class Micropost < ApplicationRecord
    belongs_to :user
    belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id, optional: true
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :watchers, dependent: :destroy
  validates :description, length: { maximum: 240 }
  #validates :user_id, presence: true
end

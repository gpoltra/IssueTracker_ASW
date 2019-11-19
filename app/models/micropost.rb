class Micropost < ApplicationRecord
  #belongs_to :user
  validates :description, length: { maximum: 240 }
  #validates :user_id, presence: true
end

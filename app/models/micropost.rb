class Micropost < ApplicationRecord
  
  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id, optional: true
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :watchers, dependent: :destroy
 
  
  def self.status
    ["New", "Open", "On hold", "Resolved", "Duplicate", "Invalid", "Won't fix", "Closed"]
  end
  def self.type
      ["Bug", "Enhancement", "Proposal", "Task"]
  end
  def self.priority
      ["Trivial", "Minor", "Major", "Critical", "Blocker"]
  end
    #validates :user_id, presence: true
    
  
  default_scope { order(created_at: :desc) }
end

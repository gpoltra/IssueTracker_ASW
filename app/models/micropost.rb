class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id, optional: true
  has_many :comments, dependent: :destroy
  has_many :Votes, dependent: :destroy
  has_many :Watchers, dependent: :destroy
  has_many_attached :things, dependent: :destroy
  validates :description, presence: true, length: { maximum: 140 }
  include Swagger::Blocks
  
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
  
#--------------------SWAGGGER API-------------------------

  swagger_schema :microposts do
    property :content do
      key :type, :string
    end
    property :user_id do
      key :type, :integer
    end
    property :created_at do
      key :type, :string
      key :format, :datetime
    end
    property :updated_at do
      key :type, :string
      key :format, :datetime
    end
    property :title do
      key :type, :string
    end
    property :description do
      key :type, :string
    end
    property :priority do
      key :type, :string
    end
    property :type_issue do
      key :type, :string
    end
    property :title do
      key :type, :string
    end
    property :assignee_id do
      key :type, :integer
    end
    property :status do
      key :type, :string
    end
    property :votes do
      key :type, :integer
    end
    property :watchers do
      key :type, :integer
    end
    property :attachment_file_name do
      key :type, :string
    end
    property :attachment_content_type do
      key :type, :string
    end
    property :attachment_file_size do
      key :type, :integer
    end
    property :attachment_updated_at do
      key :type, :string
      key :format, :datetime
    end
  end
end

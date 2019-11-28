class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  
  default_scope { order(created_at: :asc) }
end

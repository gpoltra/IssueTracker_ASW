class User < ApplicationRecord
  has_many :microposts
  has_many :comments
end

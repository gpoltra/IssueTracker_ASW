class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  attr_accessor :password, :password_confirmation
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, :uniqueness => true, format: { with: EMAIL_REGEX }
  validates :password, :confirmation => true 
  validates_length_of :password, :in => 6..20, :on => :create
  #before_save :encrypt_password
  after_save :clear_password
  def encrypt_password
    if password.present?
      #self.salt = BCrypt::Engine.generate_salt
      #self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end
  def clear_password
    self.password = nil
  end
  
  #API KEY
  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
  before_create :generate_api_key
 
end

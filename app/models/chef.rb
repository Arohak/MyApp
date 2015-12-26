class Chef < ActiveRecord::Base
  has_many :recipes
  has_many :likes
  
  before_save { self.email = email.downcase }
  validates :chefname, presence: true, length: { minimum: 3, maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 }, 
                                format: { with: VALID_EMAIL_REGEX },
                                uniqueness: { case_sensitive: false }
end
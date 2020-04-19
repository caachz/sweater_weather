class User < ApplicationRecord
  acts_as_token_authenticatable

  has_secure_password
  
  validates_presence_of :email
  validates_uniqueness_of :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

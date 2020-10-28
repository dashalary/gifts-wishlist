class User < ActiveRecord::Base
    has_secure_password
    has_many :items
    has_many :categories, through: :items
    validates :username, :email, :password, presence: true

  end
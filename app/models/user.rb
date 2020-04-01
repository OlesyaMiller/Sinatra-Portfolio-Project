class User < ActiveRecord::Base 
    has_many :blog_posts
    has_many :comments

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    has_secure_password
end
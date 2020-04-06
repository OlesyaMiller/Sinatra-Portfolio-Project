class BlogPost < ActiveRecord::Base 
    belongs_to :user
    has_many :comments

    validates :content, presence: true 
    validates :title, presence: true 
end
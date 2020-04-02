class BlogPost < ActiveRecord::Base 
    belongs_to :user
    has_many :comments

    validates :content, presence: true 
    validates :title, presence: true 
    validates :author_name, presence: true 
end
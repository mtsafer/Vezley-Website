class Post < ApplicationRecord

	validates :body, :title, presence: true
	validates :title, length: {maximum: 40}


	has_many :comments
	belongs_to :user
	belongs_to :subject

end

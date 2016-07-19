class Comment < ApplicationRecord

	validates :body, presence: true, length: {maximum: 255}

	belongs_to :post
	belongs_to :user

end

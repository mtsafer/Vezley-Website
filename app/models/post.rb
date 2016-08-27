class Post < ApplicationRecord

	validates :body, :title, presence: true
	validates :title, length: {maximum: 40}


	has_many :comments, dependent: :destroy
	belongs_to :user
	belongs_to :subject

	def find_viewing(uid)
		viewing = Viewing.find_by(post_id: self.id, user_id: uid)
		if !viewing.nil?
			viewing.viewed_at
		else
			nil
		end
	end

	def recent_activity_time
		recent = self
		comments.each do |c|
			recent = c if c.updated_at > recent.updated_at
		end
		recent.updated_at
	end

end

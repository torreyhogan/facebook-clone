class Post < ApplicationRecord
	belongs_to :author, class_name: "User"

	validates :content, presence: true

	def created_format
		self.created_at.strftime("%FT%T")
	end
end

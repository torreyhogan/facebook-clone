class Post < ApplicationRecord
	validates :content, presence: true

	belongs_to :author, class_name: "User"

	has_many :likes, foreign_key: :post_id, dependent: :destroy
	has_many :comments, foreign_key: :post_id, dependent: :destroy

	def created_format
		self.created_at.strftime("%FT%T")
	end
end

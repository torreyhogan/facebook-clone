class CommentsController < ApplicationController

	# def new
	# 	@comment = current_user.comments.build
	# end


	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			flash[:success] = "comment created"
			redirect_to @comment.post 
		else
			flash[:failure] = "comment not created"
		end
	end

	def destroy

	end

	private

		def comment_params
			params.require(:comment).permit(:post_id, :content) 
		end

end

class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build
		@post.content = params[:post][:content]
		if @post.save
			flash[:success] = "Post created"
			redirect_to @post
		else
			flash[:failure] = "Failed to create post"
			render 'new'
		end


	end

	def show
		@post = Post.find(params[:id])
		@like = @post.likes.find_by(user_id: current_user.id)
		@like ||= current_user.likes.build
		@comment = current_user.comments.build(post_id: @post.id)
	end

	def index
		friend_id = current_user.friends.map {|friend| friend.id }
		posts = Post.where(author_id: friend_id)
		@posts = posts.sort_by{|x| x.created_at}.reverse
	end

	def destroy
		@post = current_user.posts.find_by(post_id: params[:post_id])
		
	end



end

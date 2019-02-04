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
	end

	def index
		@posts = Post.all.sort_by{|x| x.created_at}.reverse
	end

	def destroy
	end



end

class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
# => the above line condenses the following two lines:
#		@comment = Comment.new(params.require(:comment).permit(:body))
#		@comment.post = @post
		@comment.creator = current_user #User.first #TODO fix after authentication

		if @comment.save
			flash[:notice] = 'Your comments was added.'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end

	end

	def vote 
		comment = Comment.find(params[:id])
		vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
		if vote.valid?
			flash[:notice] = "Your vote was counted."
		else
			flash[:notice] = "You can vote on a comment only once."
			redirect_to :back
		end
	end
end
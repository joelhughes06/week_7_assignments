 	class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  # use before_action in order to 
	# 1. set up instance variable for action
	# 2. redirect based on some condition

  def index
  	@posts = Post.all.sort_by {|x| x.total_votes}.reverse
  end

  def vote
    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    if vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:notice] = "You can vote on a post only once."
    redirect_to :back
    end
  end


  def show
# 	@post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.creator = current_user  #User.first # TODO:change once we have authentication
  	if @post.save
  		flash[:notice] = "Your post was created."
  		redirect_to posts_path
  	else #validation error
  		render :new
  	end



  end

  def edit
#  	@post = Post.find(params[:id])

  end

  def update
 # 	@post = Post.find(params[:id])

  	if @post.update(post_params)
  		flash[:notice] = "The post was updated"
  		redirect_to posts_path # alternatively post_path(post)
  	else
  		render :edit
  	end

  end


  def set_post
	@post = Post.find(params[:id])
	
	end

  private

  def post_params
#  	if user.admin?
  		params.require(:post).permit(:title, :url, :description, category_ids: [])
#  	else
#  	params.require(:post).permit(:title, :url, :creator)
#  end
  end


end

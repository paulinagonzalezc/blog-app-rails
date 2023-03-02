class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user)
    @like = current_user.likes.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by!(id: params[:id], author_id: params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end

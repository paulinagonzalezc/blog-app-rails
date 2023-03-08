class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @like = @user.likes.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by!(id: params[:id], author_id: params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    # current_user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  def destroy
    current_user = User.find(params[:user_id])
    post = Post.find_by!(id: params[:id])
    post.destroy
    current_user.decrement!(:posts_counter)
    flash[:notice] = 'The post was deleted'
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end

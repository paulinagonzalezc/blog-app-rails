class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by!(id: params[:id], author_id: params[:user_id])
  end
end

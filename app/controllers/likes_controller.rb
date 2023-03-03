class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = Like.create(post:, author: current_user)

    if like.save
      redirect_to user_post_path(post.author, post), notice: 'Post liked!'
    else
      redirect_to user_post_path(post.author, post), alert: 'Error: Post not liked.'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    like = Like.find_by(post:, user: current_user)

    if like.destroy
      redirect_to user_post_path(post.author, post), notice: 'Post unliked!'
    else
      redirect_to user_post_path(post.author, post), alert: 'Error: Post not unliked.'
    end
  end
end

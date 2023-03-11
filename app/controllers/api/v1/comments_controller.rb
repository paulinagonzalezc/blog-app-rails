class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_post, only: %i[index create]

  def index
    comments = @post.comments
    render json: comments, status: :ok
  end

  def create
    comment = @post.comments.build(comment_params)
    comment.author = @user
    comment.text = comment_params[:text]
    if comment.save
      render json: comment, status: :created, except: [:created_at, :updated_at]
    else
      render json: { errors: comment.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

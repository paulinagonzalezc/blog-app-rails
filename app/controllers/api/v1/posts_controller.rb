class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :set_user, only: %i[index create]

  def index
    posts = Post.where(author_id: @user.id)
    render json: posts, status: :ok
  end

  def show
    post = Post.find_by(id: params[:id], author_id: params[:user_id])
    if post
      render json: post, status: :ok
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  def create
    post = @user.posts.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { error: post.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Student')
    @post = Post.create(author: @user, title: 'My post', text: 'Hello!')
  end

  it 'like presence should be valid' do
    @like = Like.create(author: @user, post: @post)
    expect(@like).to be_valid
  end

  it 'update_likes_counter should increse likes' do
    Like.create(author: @user, post: @post)
    expect(@post.likes_counter).to eq 1
  end
end

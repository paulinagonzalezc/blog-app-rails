require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Student')
    @post = Post.create(author: @user, title: 'My post', text: 'Hello!')
  end

  it 'checks title presence' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'checks validation for comments counter' do
    @post.comments_counter = nil
    expect(@post).to_not be_valid
  end

  it 'checks if author id is present' do
    @post.author_id = nil
    expect(@post).to_not be_valid
  end

  it 'checks if comments counter is an integer' do
    @post.comments_counter = 'hello'
    expect(@post).to_not be_valid
  end

  it 'checks if likes counter is an integer' do
    @post.likes_counter = 'hello'
    expect(@post).to_not be_valid
  end

  describe 'Check methods in post' do
    before do
      @user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Student')
      @post1 = Post.create(author: @user, title: 'My post', text: 'Hello!')
      6.times do
        Comment.create(post: @post1, author: @user, text: 'Hi Tom!')
      end
    end

    it 'should have the five recent comments method' do
      expect(@post).to respond_to(:recent_comments)
    end

    it 'should return an empty array' do
      expect(@post1.recent_comments.count).to eql(5)
    end
  end
end

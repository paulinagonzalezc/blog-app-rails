require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Student')
  end

  it 'user name must not be blank' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts counter should be an integer' do
    @user.posts_counter = 'hello'
    expect(@user).to_not be_valid
  end

  it 'posts counter should be greater_than_or_equal_to: 0' do
    @user.posts_counter = -1
    expect(@user).to_not be_valid
  end

  describe 'methods' do
    before do
      @user1 = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Student')
      5.times do
        Post.create(author: @user1, title: 'Hello!', text: 'This is my first post')
      end
    end

    it 'returns last recent_posts' do
      expect(@user1.recent_posts).to match_array(@user1.posts.last(3))
    end
  end
end
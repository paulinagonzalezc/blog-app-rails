require 'rails_helper'

RSpec.describe 'Post Index', type: :feature do
  before :each do
    @user = User.create(
      name: 'Phyllis Smith',
      photo: 'https://roost.nbcuni.com/bin/viewasset.html/content/dam/Peacock/Campaign/landingpages/library/theoffice/characterbios/office-bio-phyllis-min.png/_jcr_content/renditions/original?downsize=1200:*&output-quality=70',
      bio: 'Sales representative',
    )
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post!')
    Comment.create(post: @post, author: @user, text: 'Happy to comment!' )
    Comment.create(post: @post, author: @user, text: 'Today is a good day!' )
    visit user_posts_path(@user.id)
  end

  it 'should have the profile picture of the user' do
    assert page.has_xpath?("//img[@src =  'https://roost.nbcuni.com/bin/viewasset.html/content/dam/Peacock/Campaign/landingpages/library/theoffice/characterbios/office-bio-phyllis-min.png/_jcr_content/renditions/original?downsize=1200:*&output-quality=70'
    and @alt='user photo']")
  end

  it 'should have the username of the user' do
    expect(page).to have_content(@user.name)
  end

  it 'should have the number of posts of the user' do
    expect(page).to have_content('Number of posts: 1')
  end

  it 'should have the title of a post' do
    expect(page).to have_content(@post.title)
  end

  it 'should have the body of a post' do
    expect(page).to have_content('This is my first post!')
  end

  it 'should have the first comments of a post' do
    expect(page).to have_content('Happy to comment!')
  end

  it 'should have the number of comments for a post' do
    expect(page).to have_content('Comments: 2')
  end

  it 'should have the number of likes for a post' do
    expect(page).to have_content('Likes: 0')
  end

  it 'should have a section for pagination' do
    expect(page).to have_content('Pagination')
  end

  it 'should redirect to posts show page' do
    click_on 'Hello'
    expect(page).to have_current_path user_post_path(@user.id, @post.id)
  end
end
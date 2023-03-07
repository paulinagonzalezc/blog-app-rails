require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Paulina',
      photo: 'https://cdn-icons-png.flaticon.com/512/3220/3220315.png',
      bio: 'Artist',
      posts_counter: 3
    )
    @user2 = User.create(
      name: 'Julian',
      photo: 'https://cdn-icons-png.flaticon.com/512/4128/4128176.png',
      bio: 'Engineer',
      posts_counter: 0
    )
    visit root_path
  end

  it 'should have the username of all users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'should have the photo of each user' do
    assert page.has_xpath?("//img[@src = 'https://cdn-icons-png.flaticon.com/512/3220/3220315.png'
    and @alt = 'user photo']")
    assert page.has_xpath?("//img[@src = 'https://cdn-icons-png.flaticon.com/512/4128/4128176.png'
    and @alt = 'user photo']")
  end

  it 'should have the users number of posts' do
    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Number of posts: 0')
  end

  it 'should redirect to that users show page on click' do
    click_link(@user1.name)
    expect(page).to have_current_path user_path(@user1.id)
  end
end

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    # If response status was correct.
    it 'returns a success response' do
      user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end
    # If a correct template was rendered.
    it 'renders the index template' do
      user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end
    # If the response body includes correct placeholder text.
    it 'includes the correct placeholder text in the response body' do
      user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      post = Post.create(title: 'My First Post', text: 'Hello World', author: user)
      get "/users/#{user.id}/posts"
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET #show' do
    # If response status was correct.
    it 'returns a success response' do
      user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      post = Post.create(title: 'My First Post', text: 'Hello World', author: user)
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
    # If a correct template was rendered.
    it 'renders the show template' do
      user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      post = Post.create(title: 'My First Post', text: 'Hello World', author: user)
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end
    # If the response body includes correct placeholder text.
    it 'includes the correct placeholder text in the response body' do
      user = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      post = Post.create(title: 'My First Post', text: 'Hello World', author: user)
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include(post.title)
      expect(response.body).to include(post.text)
    end
  end
end

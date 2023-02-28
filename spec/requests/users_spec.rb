require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    # If response status was correct.
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
    end
    # If a correct template was rendered.
    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
    # If the response body includes correct placeholder text.
    it 'displays the correct users' do
      user1 = User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer')
      user2 = User.create(name: 'Julian', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Astronaut')
      get users_path
      expect(response.body).to include(user1.name)
      expect(response.body).to include(user2.name)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'Paulina', photo: 'https://unsplash.com/es/fotos/vuBaykPW1Dk', bio: 'Engineer') }
    # If response status was correct.
    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
    # If a correct template was rendered.
    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end
    # If the response body includes correct placeholder text.
    it 'displays the correct user' do
      get user_path(user)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.photo)
      expect(response.body).to include(user.bio)
    end
  end
end

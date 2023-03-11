require 'swagger_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  fixtures :users # load the users fixture
  describe 'GET /api/v1/users/:user_id/posts/' do
    it 'returns status code 200' do
      user = users(:paulina) # use the paulina fixture
      get api_v1_user_posts_path(user)
      expect(response).to have_http_status(200)
    end
  end
end

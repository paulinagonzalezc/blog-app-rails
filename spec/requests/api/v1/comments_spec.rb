require 'swagger_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  fixtures :users, :posts # load the users fixture
  describe 'GET /api/v1/users/:user_id/posts/:post_id/comments' do
    it 'returns status code 200' do
      user = users(:paulina) # use the paulina fixture
      post = posts(:post1) # use the post_1 fixture
      get api_v1_user_post_comments_path(user.id, post.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/users/:user_id/posts/:post_id/comments' do
    fixtures :users, :posts
    it 'checks if comment has been added' do
      user = users(:paulina) # use the paulina fixture
      post = posts(:post1) # use the post_1 fixture
      valid_attributes = {
        comment: {
          post: posts(:post1),
          author: users(:paulina),
          text: 'Hello there'
        }
      }
      post api_v1_user_post_comments_path(user.id, post.id), params: valid_attributes
      puts response.body
      expect(response).to have_http_status(201)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['text']).to eq('Hello there')
    end
  end
end

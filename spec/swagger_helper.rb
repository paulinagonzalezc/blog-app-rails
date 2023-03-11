# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {
        '/api/v1/users/{user_id}/posts': {
        get: {
          summary: 'List all posts for a user',
          parameters: [
            {
              name: 'user_id',
              in: 'path',
              description: 'ID of the user',
              required: true,
              schema: {
                type: 'integer'
              }
            }
          ],
          responses: {
            '200': {
              description: 'A list of posts',
              content: {
                'application/json': {
                  schema: {
                    type: 'array',
                    items: {
                      type: 'object',
                      properties: {
                        id: { type: 'integer' },
                        title: { type: 'string' },
                        body: { type: 'string' }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      },
      '/api/v1/users/{user_id}/posts/{post_id}/comments': {
        get: {
          summary: 'List all comments for a user\'s post',
          parameters: [
            {
              name: 'user_id',
              in: 'path',
              description: 'ID of the user',
              required: true,
              schema: {
                type: 'integer'
              }
            },
            {
              name: 'post_id',
              in: 'path',
              description: 'ID of the post',
              required: true,
              schema: {
                type: 'integer'
              }
            }
          ],
          responses: {
            '200': {
              description: 'A list of comments',
              content: {
                'application/json': {
                  schema: {
                    type: 'array',
                    items: {
                      type: 'object',
                      properties: {
                        id: { type: 'integer' },
                        body: { type: 'string' },
                        created_at: { type: 'string', format: 'date-time' },
                        user: {
                          type: 'object',
                          properties: {
                            id: { type: 'integer' },
                            name: { type: 'string' }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
      },
      post: {
          summary: 'Add a comment to a post',
          parameters: [
            {
              name: 'user_id',
              in: 'path',
              description: 'ID of the user',
              required: true,
              schema: {
                type: 'integer'
              }
            },
            {
              name: 'post_id',
              in: 'path',
              description: 'ID of the post',
              required: true,
              schema: {
                type: 'integer'
              }
            },
            {
              name: 'text',
              in: 'body',
              description: 'The comment to add',
              required: true,
              schema: {
                type: 'object',
                properties: {
                  body: { type: 'string' }
                }
              }
            }
          ],
          responses: {
            '201': {
              description: 'The created comment',
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      id: { type: 'integer' },
                      body: { type: 'string' },
                      created_at: { type: 'string', format: 'datetime' },
                        user: {
                          type: 'object',
                          properties: {
                            id: { type: 'integer' },
                            name: { type: 'string' }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        },
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end

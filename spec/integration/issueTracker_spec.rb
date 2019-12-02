require 'swagger_helper'

describe 'IssueTracker API' do

  path '/microposts' do

    get 'Get all Issues' do
      tags 'Issues'
      produces 'application/json', 'application/xml'

      response '200', 'found' do
        schema type: :object,
          properties: {
            content: {type: :string},
            user_id: {type: :integer},
            created_at: {type: :string, format: :datetime},
            updated_at: {type: :string, format: :datetime},
            title: {type: :string},
            description: {type: :string},
            priority: {type: :string},
            type_issue: {type: :string},
            assignee_id: {type: :integer},
            status: {type: :string},
            votes: {type: :integer},
            watchers: {type: :integer},
            attachment_file_name: {type: :string},
            attachment_content_type: {type: :string},
            attachment_file_size: {type: :integer},
            attachment_updated_at: {type: :string, format: :datetime}
          }
      end

      response '404', 'pet not found' do
      end
    end
  end
end
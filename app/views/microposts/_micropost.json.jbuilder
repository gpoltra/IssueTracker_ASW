json.extract! micropost, :content, :user_id, :created_at, :updated_at, :title, :description, :priority, :type_issue, :assignee_id, :status, :votes, :watchers
json.url micropost_url(micropost, format: :json)

json.extract! micropost, :id, :title, :type_issue, :priority, :status, :user_id, :created_at, :updated_at
json.url micropost_url(micropost, format: :json)

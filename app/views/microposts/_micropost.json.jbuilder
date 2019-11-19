json.extract! micropost, :id, :title, :type, :priority, :user_id, :created_at, :updated_at
json.url micropost_url(micropost, format: :json)

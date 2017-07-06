json.extract! user_leave, :id, :user_id, :leave_id, :leave_left, :leave_taken, :created_at, :updated_at
json.url user_leave_url(user_leave, format: :json)

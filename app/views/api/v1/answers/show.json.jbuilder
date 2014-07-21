json.extract! @answer, :id, :created_at, :updated_at, :text
json.url question_url(@answer, format: :json)

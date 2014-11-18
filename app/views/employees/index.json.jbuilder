json.array!(@employees) do |student|
  json.extract! student, :id, :name, :phone_number, :email, :has_badge, :badge_observation, :birthday, :address
  json.url student_url(student, format: :json)
end

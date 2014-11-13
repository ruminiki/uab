json.array!(@registrations) do |registration|
  json.extract! registration, :id, :student_id, :course_class_id, :note
  json.url registration_url(registration, format: :json)
end

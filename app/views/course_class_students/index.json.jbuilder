json.array!(@course_class_students) do |course_class_student|
  json.extract! course_class_student, :id, :student_id, :course_class_id, :note
  json.url course_class_student_url(course_class_student, format: :json)
end

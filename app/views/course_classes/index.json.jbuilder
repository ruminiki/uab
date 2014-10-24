json.array!(@course_classes) do |course_class|
  json.extract! course_class, :id, :name, :institution_id, :course_id, :begin
  json.url course_class_url(course_class, format: :json)
end

json.array!(@employee_categories) do |employee_category|
  json.extract! employee_category, :id, :name
  json.url employee_category_url(employee_category, format: :json)
end

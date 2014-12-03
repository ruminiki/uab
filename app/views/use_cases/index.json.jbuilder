json.array!(@use_cases) do |use_case|
  json.extract! use_case, :id, :name, :class_name
  json.url use_case_url(use_case, format: :json)
end

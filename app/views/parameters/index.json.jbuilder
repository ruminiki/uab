json.array!(@parameters) do |parameter|
  json.extract! parameter, :id, :name, :value
  json.url parameter_url(parameter, format: :json)
end

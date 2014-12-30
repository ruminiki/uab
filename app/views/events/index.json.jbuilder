json.array!(@events) do |event|
  json.extract! event, :id, :name, :begin, :end
  json.url event_url(event, format: :json)
end

json.array!(@registration_statuses) do |registration_status|
  json.extract! registration_status, :id, :name
  json.url registration_status_url(registration_status, format: :json)
end

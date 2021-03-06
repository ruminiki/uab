json.array!(@institutions) do |institution|
  json.extract! institution, :id, :name, :phone_number, :email, :site
  json.url institution_url(institution, format: :json)
end

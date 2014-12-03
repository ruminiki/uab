json.array!(@authorizations) do |authorization|
  json.extract! authorization, :id, :user_id, :use_case_id, :add, :edit, :view, :delete
  json.url authorization_url(authorization, format: :json)
end

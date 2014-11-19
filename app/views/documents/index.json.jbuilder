json.array!(@documents) do |document|
  json.extract! document, :id, :name, :document_category_id, :path, :extension, :size
  json.url document_url(document, format: :json)
end

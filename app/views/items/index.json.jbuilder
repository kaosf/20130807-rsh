json.array!(@items) do |item|
  json.extract! item, :name
  json.url item_url(item, format: :json)
end

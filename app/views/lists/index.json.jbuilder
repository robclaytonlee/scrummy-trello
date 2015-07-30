json.array!(@lists) do |list|
  json.extract! list, :id, :trello_id, :name, :closed, :position
  json.url list_url(list, format: :json)
end

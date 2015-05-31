json.array!(@boards) do |board|
  json.extract! board, :id, :name, :trello_id, :last_sync_date
  json.url board_url(board, format: :json)
end

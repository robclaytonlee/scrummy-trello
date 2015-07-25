json.array!(@boards) do |board|
  json.extract! board, :id, :name, :trello_id, :trello_url, :cards_count, :last_sync_date
  json.url board_url(board, format: :json)
end

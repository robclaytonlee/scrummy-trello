json.array!(@cards) do |card|
  json.extract! card, :id, :name, :trello_id, :trello_url, :board_id, :points
  json.url card_url(card, format: :json)
end

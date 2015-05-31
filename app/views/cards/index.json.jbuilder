json.array!(@cards) do |card|
  json.extract! card, :id, :title, :trello_id, :url, :board_id, :points
  json.url card_url(card, format: :json)
end

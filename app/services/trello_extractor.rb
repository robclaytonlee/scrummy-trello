# app/services/trello_extractor.rb

class TrelloExtractor

  @@auth_params = ["key=#{Rails.application.secrets.trello_dev_public_key}",
                   "token=#{Rails.application.secrets.trello_member_token}"].join('&')

  def extract_cards(trello_board_id)
    url = "https://api.trello.com/1/board/#{trello_board_id}/cards?fields=name,labels,url&#{@@auth_params}"
    response = RestClient.get url, { accept: :json }
    JSON.parse(response)
  end

  def import_cards(trello_cards)
    n = 0
    trello_cards.each do |element|
      c = Card.find_or_initialize_by(trello_id: element["id"])

      # Compute points from labels which are assumed to be numeric
      points = 0
      element["labels"].each do |label|
        points += label["name"].to_f
      end

      c.update(name: element["name"], board_id: 4, trello_url: element["url"], points: points)
      n+=1
      break unless n < 20
    end
  end
end

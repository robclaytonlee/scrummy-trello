# app/services/trello_extractor.rb

class TrelloExtractor

  @@auth_params = ["key=#{Rails.application.secrets.trello_dev_public_key}",
                   "token=#{Rails.application.secrets.trello_member_token}"].join('&')

  def extract_cards(trello_board_id)
    url = "https://api.trello.com/1/board/#{trello_board_id}/cards?fields=name,labels&#{@@auth_params}"
    response = RestClient.get url, { accept: :json }
    JSON.parse(response)
  end
end

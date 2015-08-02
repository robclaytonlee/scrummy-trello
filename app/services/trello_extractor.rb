# app/services/trello_extractor.rb

class TrelloExtractor

  attr_reader :board_id, :trello_board_id, :lists, :last_sync_date

  @@auth_params = ["key=#{Rails.application.secrets.trello_dev_public_key}",
                   "token=#{Rails.application.secrets.trello_member_token}"].join('&')

  def initialize(board_id)
    @board_id = board_id
    b = Board.where(id: board_id).select(:trello_id, :last_sync_date).first
    @trello_board_id, @last_sync_date = b.trello_id, b.last_sync_date
    @lists = {}
  end

  def trello_lists
    url = "https://api.trello.com/1/boards/#{@trello_board_id}/lists/open?cards=none&#{@@auth_params}"
    response = RestClient.get url, { accept: :json }
    JSON.parse(response)
  end

  def sync_lists
    n = 0

    t_lists = trello_lists
    t_lists.each do |element|
      l = List.find_or_initialize_by(trello_id: element["id"])
      l.update(name: element["name"], board_id: @board_id, closed: element["closed"], position: element["pos"])
      n+=1
      # Initialize a Hash for easily getting the list id given the trello list id
      @lists[element["id"]] = l.id
    end
    n
  end

  def trello_cards
    url = "https://api.trello.com/1/board/#{@trello_board_id}/cards?fields=name,labels,url,idShort,idList,dateLastActivity&#{@@auth_params}"
    response = RestClient.get url, { accept: :json }
    JSON.parse(response)
  end

  def sync_cards(force = false)
    n = 0
    t = Time.now

    if @lists.count == 0 then sync_lists end

    t_cards = trello_cards
    t_cards.each do |element|

      if force || element["dateLastActivity"] > @last_sync_date
        c = Card.find_or_initialize_by(trello_id: element["id"])
        pts = points(element["labels"])
        list_id = @lists[element["idList"]]
        c.update(name: element["name"], board_id: @board_id, list_id: list_id, short_id: element["idShort"], trello_url: element["url"], points: pts)
        n+=1
      end
    end
    Board.where(id: @board_id).update_all(last_sync_date: t)
    @last_sync_date = t
    n
  end

  def trello_labels
    url = "https://api.trello.com/1/boards/#{@trello_board_id}/labels?#{@@auth_params}"
    response = RestClient.get url, { accept: :json }
    JSON.parse(response)
  end

  def sync_labels
    n = 0

    t_labels = trello_labels
    t_labels.each do |element|
      l = Label.find_or_initialize_by(trello_id: element["id"])
      l.update(name: element["name"], board_id: @board_id, color: element["color"])
      n+=1
    end
    n
  end

  def attach_label(trello_card_id, label_name)
    label_trello_id = Label.where(board_id: board_id, name: label_name).pluck(:trello_id).first
    url = "https://api.trello.com/1/cards/#{trello_card_id}/idLabels?#{@@auth_params}"
    response = RestClient.post url, { value: label_trello_id, accept: :json }
    JSON.parse(response)
  end

  def remove_label(trello_card_id, label_name)
    label_trello_id = Label.where(board_id: board_id, name: label_name).pluck(:trello_id).first
    url = "https://api.trello.com/1/cards/#{trello_card_id}/idLabels/#{label_trello_id}?#{@@auth_params}"
    response = RestClient.delete url, { accept: :json }
    JSON.parse(response)
  end

  def points(labels = [])
    pts = 0

    # Compute points from labels which are assumed to be numeric
    labels.each do |l|
      pts += l["name"].to_f
    end
    pts
  end
  private :points

end

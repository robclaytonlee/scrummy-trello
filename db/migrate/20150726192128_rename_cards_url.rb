class RenameCardsUrl < ActiveRecord::Migration
  def change
    rename_column :cards, :url, :trello_url
  end
end

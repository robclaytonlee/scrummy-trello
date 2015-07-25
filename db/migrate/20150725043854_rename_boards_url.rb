class RenameBoardsUrl < ActiveRecord::Migration
  def change
    rename_column :boards, :url, :trello_url
  end
end

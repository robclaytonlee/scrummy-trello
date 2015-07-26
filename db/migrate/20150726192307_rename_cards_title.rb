class RenameCardsTitle < ActiveRecord::Migration
  def change
    rename_column :cards, :title, :name
  end
end

class AddCardsCountToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :cards_count, :integer
  end
end

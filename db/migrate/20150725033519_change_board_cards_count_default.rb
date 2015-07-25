class ChangeBoardCardsCountDefault < ActiveRecord::Migration

  def change
    change_column_default :boards, :cards_count, 0
  end

end

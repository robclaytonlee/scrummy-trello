class AddShortIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :short_id, :string
  end
end

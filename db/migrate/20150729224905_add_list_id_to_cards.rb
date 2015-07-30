class AddListIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :list_id, :integer, :null => false

    add_foreign_key :cards, :lists

    add_index :cards, :list_id
  end
end

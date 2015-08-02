class ChangeLabels < ActiveRecord::Migration
  def change
    add_column :labels, :trello_id, :string, :null => false
    add_column :labels, :board_id, :integer, :null => false
    add_column :labels, :color, :string
    remove_column :labels, :card_id, :integer
    remove_column :labels, :type, :string

    add_foreign_key :labels, :boards

    add_index :labels, :board_id
  end
end

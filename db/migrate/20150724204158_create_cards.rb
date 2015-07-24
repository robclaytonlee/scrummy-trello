class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title, null: false
      t.integer :board_id, null: false
      t.string :trello_id, null: false
      t.string :url, null: false
      t.float :points

      t.timestamps
    end

    add_foreign_key :cards, :boards

    add_index :cards, :title
    add_index :cards, :board_id
  end
end

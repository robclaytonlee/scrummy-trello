class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.string :trello_id, null: false
      t.datetime :last_sync_date
      t.integer :cards_count, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :boards, :name
    add_index :boards, :cards_count
  end
end

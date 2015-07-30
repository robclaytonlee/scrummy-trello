class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.references :board, null: false
      t.string :trello_id, null: false
      t.boolean :closed, null: false
      t.integer :position, null: false
      t.integer :cards_count, null: false, :default => 0

      t.timestamps null: false
    end

    add_foreign_key :lists, :boards

    add_index :lists, :name
    add_index :lists, :trello_id

  end
end

class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.string :trello_id
      t.string :url
      t.integer :board_id
      t.float :points

      t.timestamps
    end
  end
end

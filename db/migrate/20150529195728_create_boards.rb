class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.string :trello_id
      t.datetime :last_sync_date

      t.timestamps
    end
  end
end

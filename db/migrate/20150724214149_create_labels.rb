class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name, null: false
      t.references :card, null: false
      t.string :type, null: false

      t.timestamps
    end

    add_foreign_key :labels, :cards

    add_index :labels, :name
    add_index :labels, :card_id
  end
end

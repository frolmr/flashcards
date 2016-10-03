class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.belongs_to :user, index: true
      t.boolean :current, default: false

      t.timestamps null: false
    end

    change_table :cards do |t|
      t.belongs_to :deck, index: true
    end
  end
end

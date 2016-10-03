class AddNameToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :name, :string
  end
end

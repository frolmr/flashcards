class AddBoxAndBadTriesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :box, :integer, default: 0
    add_column :cards, :bad_tries, :integer, default: 0
  end
end

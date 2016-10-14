class ChangeBoxOfCard < ActiveRecord::Migration
  def change
    rename_column :cards, :box, :review_group
  end
end

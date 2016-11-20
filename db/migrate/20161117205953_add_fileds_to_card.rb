class AddFiledsToCard < ActiveRecord::Migration
  def change
    remove_column :cards, :review_group, :integer
    remove_column :cards, :bad_tries, :integer
    add_column :cards, :e_factor, :decimal, precision: 3, scale: 2, default: 2.5
    add_column :cards, :repetition, :integer, default: 1
    add_column :cards, :review_interval, :integer, default: 1
  end
end

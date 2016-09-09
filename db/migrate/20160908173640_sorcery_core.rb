class SorceryCore < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password, :crypted_password
      t.string :salt
    end

    change_column_null :users, :email, false
    add_index :users, :email, unique: true
  end
end
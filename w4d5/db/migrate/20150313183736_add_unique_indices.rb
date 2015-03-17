class AddUniqueIndices < ActiveRecord::Migration
  def change
    add_index :subs, :title, unique: true
    add_index :users, :username, unique: true
    add_index :users, :session_token, unique: true
  end
end

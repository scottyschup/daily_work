class ChangeUserColumns < ActiveRecord::Migration
  def change
    drop_table :users

    create_table :users do |t|
      t.string :username
      
      t.timestamps
    end
  end
end

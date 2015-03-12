class CreateUsersTableAgain < ActiveRecord::Migration
  def change
    drop_table :users

    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.timestamps
    end
  end
end

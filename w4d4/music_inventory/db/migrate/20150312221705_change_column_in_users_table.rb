class ChangeColumnInUsersTable < ActiveRecord::Migration
  def change
    rename_column :users, :auth_token, :session_token
  end
end

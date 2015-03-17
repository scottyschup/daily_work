class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false, unique: true
      t.text :description
      t.integer :moderator_id, null: false, index: true

      t.timestamps null: false
    end
  end
end

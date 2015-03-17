class CreatePostSub < ActiveRecord::Migration
  def up
    create_table :post_subs do |t|
      t.integer :post_id, null: false, index: true
      t.integer :sub_id, null: false, index: true

      t.timestamps null: false
    end

    remove_column :posts, :sub_id
  end

  def down
    drop_table :post_subs
    add_column :posts, :sub_id, :integer, null: false, index: true
  end
end

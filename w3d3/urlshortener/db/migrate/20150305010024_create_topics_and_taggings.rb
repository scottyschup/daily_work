class CreateTopicsAndTaggings < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :topic_id, null: false
      t.integer :shortened_url_id, null: false
      t.timestamps
    end
  end
end

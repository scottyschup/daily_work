class RenameTopicToTagTopic < ActiveRecord::Migration
  def change
    rename_table :topics, :tag_topics
  end
end

class RemoveExtraneousBandColumn < ActiveRecord::Migration
  def change
    remove_column :bands, :recording_type
  end
end

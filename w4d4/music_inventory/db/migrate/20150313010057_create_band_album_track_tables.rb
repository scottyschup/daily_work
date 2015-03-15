class CreateBandAlbumTrackTables < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.string :recording_type, null: false

      t.timestamps
    end

    create_table :albums do |t|
      t.string :name, null: false
      t.string :album_type
      t.integer :band_id, null: false

      t.timestamps
    end

    create_table :tracks do |t|
      t.string :name, null: false
      t.string :track_type
      t.integer :album_id
      t.text :lyrics

      t.timestamps
    end

    add_index :bands, :name, unique: true
    add_index :albums, :band_id
    add_index :tracks, :album_id
  end
end

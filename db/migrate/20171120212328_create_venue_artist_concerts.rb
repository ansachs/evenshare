class CreateVenueArtistConcerts < ActiveRecord::Migration[5.1]
  def change
    create_table :venue_artist_concerts do |t|
      t.belongs_to :artist
      t.belongs_to :venue
      t.belongs_to :concert

      t.timestamps
    end
  end
end

class CreateConcertBands < ActiveRecord::Migration[5.1]
  def change
    create_table :concert_bands do |t|
      t.belongs_to :concert_id
      t.belongs_to :band_id

      t.timestamps
    end
  end
end

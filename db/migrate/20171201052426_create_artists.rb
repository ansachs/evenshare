class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.belongs_to :band
      t.string :name

      t.timestamps
    end
  end
end

class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :title
      t.string :description
      t.string :genre

      t.timestamps
    end
  end
end

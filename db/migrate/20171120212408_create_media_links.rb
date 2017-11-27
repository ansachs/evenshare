class CreateMediaLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :media_links do |t|
      t.belongs_to :concert
      t.belongs_to :user
      t.string :media_type
      t.string :link

      t.timestamps
    end
  end
end

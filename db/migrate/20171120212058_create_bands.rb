class CreateBands < ActiveRecord::Migration[5.1]
  def change
    create_table :bands do |t|
      t.string :title
      t.string :description
      t.string :twitter

      t.timestamps
    end
  end
end

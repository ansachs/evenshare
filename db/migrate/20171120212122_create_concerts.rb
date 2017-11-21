class CreateConcerts < ActiveRecord::Migration[5.1]
  def change
    create_table :concerts do |t|
      t.string   :title
      t.string   :description
      # t.monetize :price
      t.string   :ticket_info
      t.integer  :api_id

      t.timestamps
    end
  end
end

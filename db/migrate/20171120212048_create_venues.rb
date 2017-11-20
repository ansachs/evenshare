class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string  :title
      t.string  :address
      t.string  :city
      t.string  :state
      t.string  :phone
      t.string  :hours
      t.string  :description
      t.timestamps
    end
  end
end

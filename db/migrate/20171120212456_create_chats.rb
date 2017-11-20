class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.belongs_to :user
      t.belongs_to :concert
      t.string :statement

      t.timestamps
    end
  end
end

class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.belongs_to :chat_box
      t.string :statement

      t.timestamps
    end
  end
end

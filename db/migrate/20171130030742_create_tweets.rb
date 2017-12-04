class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :user
      t.string :message
      t.belongs_to :concert
      t.bigint :twitterID

      t.timestamps
    end
  end
end

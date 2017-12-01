class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :user
      t.string :message
      t.integer :concert_id
      t.bigint :twitterID

      t.timestamps
    end
  end
end

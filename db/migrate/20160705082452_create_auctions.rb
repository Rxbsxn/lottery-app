class CreateAuctions < ActiveRecord::Migration[5.0]
  def change
    create_table :auctions do |t|
      t.string :name
      t.string :content
      t.string :imageUrl

      t.timestamps
    end
  end
end

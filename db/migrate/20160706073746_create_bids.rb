class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.string :bidders

      t.timestamps
    end
  end
end

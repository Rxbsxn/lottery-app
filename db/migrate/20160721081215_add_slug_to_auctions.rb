class AddSlugToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :slug, :string
  end
end

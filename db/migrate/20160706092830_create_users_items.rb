class CreateUsersItems < ActiveRecord::Migration[5.0]
  def change
    create_table :auctions_users, id: false do |t|
      t.references :user
      t.references :auction
    end
  end
end

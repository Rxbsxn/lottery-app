class Auction < ApplicationRecord
  resourcify

  max_paginates_per 6
  has_and_belongs_to_many :users

end

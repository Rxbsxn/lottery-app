class Auction < ApplicationRecord
  resourcify
  self.per_page = 6
  has_and_belongs_to_many :users

end

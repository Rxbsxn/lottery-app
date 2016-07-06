class Item < ApplicationRecord
resourcify
  belongs_to :user

  has_many :bids
end

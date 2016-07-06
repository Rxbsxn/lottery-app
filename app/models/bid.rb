class Bid < ApplicationRecord
belongs_to :auction
            :user
            :amount
            :bidders
end

class Auction < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  resourcify
  self.per_page = 6
  has_and_belongs_to_many :users
  belongs_to :winner, class_name: User

  def should_generate_new_friendly_id?
    new_record?
  end
end
Auction.find_each(&:save)

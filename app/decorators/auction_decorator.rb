class AuctionDecorator < Draper::Decorator
  delegate_all
  decorates_finders
end

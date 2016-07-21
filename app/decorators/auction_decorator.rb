class AuctionDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  include Draper::LazyHelpers

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def show
    link_to 'Read more', auction_path(auction)
  end

  def delete
    if is_admin?
      link_to 'Destroy', auction, method: :delete, data: { confirm: 'Are you sure?' }
    end
  end

  def run_draw_or_bid
    if can_run_draw?
      link_to 'Run draw', draw_auction_path(auction), method: :post
    elsif current_user
      link_to 'Bid It', bid_auction_path(bid: { auction_id: auction.id }), method: :post
    end
  end

  private

  def is_admin?
    current_user && current_user.has_role?(:admin)
  end

  def can_run_draw?
    auction.users.size >= 2 && is_admin?
  end
end

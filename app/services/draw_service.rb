class DrawService
  def initialize(auction)
    @auction = auction
    @errors = []
  end

  def erorrs
    @errors
  end

  def call
    if enough_bids?
      shuffle_winner
    else
      @errors << 'Error'
    end
  end

  private

  def shuffle_winner
    # users = auction.users.all
    winner = auction.users.order('RANDOM()').last
    auction.winner = winner
    auction.save
    redirect_to auction
  end

  def enough_bids?
    auction.users.count >= 2 ? true : false
  end
end

class DrawService
  def initialize(auction)
    @auction = auction
    @errors = []
  end

  def errors
    @errors
  end

  def call
    shuffle_winner if enough_bids?
  end

  # private

  def shuffle_winner
    # users = auction.users.all
    winner = @auction.users.order('RANDOM()').last
    @auction.winner = winner
    @auction.save
  end

  def enough_bids?
    if @auction.users.count >= 2
      true
    else
      @errors << 'Error'
      false
    end
  end
end

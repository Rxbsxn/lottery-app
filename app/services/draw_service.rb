class DrawService
  attr_reader :errors

  def initialize(auction)
    @auction = auction
    @errors = []
  end

  def call
    shuffle_winner if enough_bids?
  end

  private

  def send_mail
    UserMailer.send_win_confirmation(auction).deliver_now
  end

  def shuffle_winner
    winner = @auction.users.order('RANDOM()').last
    @auction.winner = winner
    @auction.save
    send_mail
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


class UserMailer < ApplicationMailer
  default from: 'notifcation@example'

  def send_win_confirmation(auction)
    @auction = auction
    mail(to: auction.winner.email, subject: 'You win the lottery')
  end
end

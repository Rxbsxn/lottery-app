class AuctionsController < ApplicationController
  def index
    @auction = Auction.all
  end

  def new
    @auction = Auction.new
  end

end

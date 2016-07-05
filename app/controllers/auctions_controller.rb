class AuctionsController < ApplicationController
  def index
    @auction = Auction.all
  end

  def new
    @auction = Auction.new
  end
  def create
  @auction = Auction.new(auction_params)
  if @auction.save
    redirect_to auctions_path
  else
    render 'new'
  end
end



  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy
    redirect_to auctions_path
  end

  def show
    @auction = Auction.find(params[:id])
  end


  private
  def auction_params
    params.require(:auction).permit(:name, :content, :imageUrl)
  end

end

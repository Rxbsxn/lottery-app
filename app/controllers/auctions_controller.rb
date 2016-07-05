class AuctionsController < ApplicationController
  def index
    @auction = Auction.all
  end

  def new
    @auction = Auction.new
  end
  def create
  @auction = Article.new(article_params)
  if @auction.save
    redirect_to '/auctions'
  else
    render 'new'
  end
end

  private
  def auction_params
    params.require(:auction).permit(:name, :content, :imageUrl)
  end

end

class AuctionsController < ApplicationController
  before_action :is_admin , except: [:index, :show,]


  def index
    @auction = Auction.page(params[:page]).per(6)
  end

  def search
    @names = Auction.ransack(params[:names])
    @product = @names.result(distinct: true)
  end

  def new
    @auction = Auction.new
  end

  def bid
    auction = Auction.find(params[:id])
    auction.users << current_user
    redirect_to auction
  end

  def draw
    auction = Auction.find(params[:id])
    users = auction.users.all

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
    # @bid = Bid.new
  end


  private
  def auction_params
    params.require(:auction).permit(:name, :content, :imageUrl)
  end

  def is_admin
    unless  current_user && current_user.has_role?(:admin)
      redirect_to auctions_path
    end

  end

end

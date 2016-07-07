class AuctionsController < ApplicationController
  before_action :is_admin , except: [:index, :show, :bid]
<<<<<<< HEAD
  before_action :authenticate_user! , only: [:bid]
=======
  before_action :authenticate_user!, only: [:bid]
>>>>>>> d2dcd164df7d760936285f0441bd4aeabeb5783d


  def index
    @q = Auction.ransack(search_params)
    @auction = @q.result.page(params[:page])
  end

  def search

  end

  def new
    @auction = Auction.new
  end



  def draw
    auction = Auction.find(params[:id])
    users = auction.users.all
    winner = users.order('RANDOM()').last
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
  def bid
    @auction = Auction.find(params[:id])
      @auction.users << current_user
      redirect_to @auction
    end



  end

  def place_a_bid(bid,amount)

  end
  private
  def auction_params
    params.require(:auction).permit(:name, :content, :imageUrl)
  end

  def search_params
    params.permit(q:[:name_cont])[:q].to_h
  end
  def is_admin
    unless  current_user && current_user.has_role?(:admin)
      redirect_to auctions_path
    end

  end

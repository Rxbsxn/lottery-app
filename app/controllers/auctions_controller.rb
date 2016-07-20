class AuctionsController < ApplicationController
  before_action :is_admin, except: [:index, :show, :bid, :new]
  before_action :authenticate_user!, only: [:bid]
  expose :auctions, -> { Auction.all }
  expose :auction
  decorates_assigned :auctions

  def index
    @q = Auction.ransack(search_params)
    @auctions = @q.result.page(params[:page])
  end

  def new
    auction = Auction.new
  end

  def draw
    auction = Auction.find(params[:id])
    draw_service = DrawService.new(auction)
    flash[:error] = draw_service.errors unless draw_service.call
    redirect_to auction
  end

  def create
    auction = Auction.new(auction_params)
    if auction.save
      redirect_to auctions_path
    else
      render 'new'
    end
  end

  def destroy
    auction = Auction.find(params[:id])
    auction.destroy
    redirect_to auctions_path
  end

  def show
    auction = AuctionDecorator.find(params[:id])
  end

  def bid
    auction = Auction.find(params[:id])
    auction.users << current_user
    redirect_to auction
  end
end

  private

def auction_params
  params.require(:auction).permit(:name, :content, :imageUrl)
end

def search_params
  params.permit(q: [:name_cont])[:q].to_h
end

def is_admin
  unless  current_user && current_user.has_role?(:admin)
    redirect_to auctions_path
  end
end

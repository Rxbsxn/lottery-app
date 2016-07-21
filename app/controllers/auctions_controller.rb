class AuctionsController < ApplicationController
  before_action :admin?, except: [:index, :show, :bid, :new]
  before_action :authenticate_user!, only: [:bid]
  expose :q, -> { Auction.ransack(search_params) }
  expose :auctions, -> { q.result(distinct: true).page(params[:page]).decorate }
  expose :auction, decorate: ->(auction) { auction.decorate }, find_by: :slug

  def draw
    draw_service = DrawService.new(auction)
    flash[:error] = draw_service.errors unless draw_service.call
    redirect_to auction
  end

  def create
    if auction.save
      redirect_to auction_path(auction)
    else
      render :new
    end
  end

  def destroy
    auction.destroy
    redirect_to auction_path(auction)
  end

  def bid
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

def admin?
  unless  current_user && current_user.has_role?(:admin)
    redirect_to auctions_path
  end
end

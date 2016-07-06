class BidsController < ApplicationController
  def index
    @bids = Bid.new
  end

  def new
    @bids = Bid.new
  end
  def create
    @bids = Bid.new(bids_params)
  if @bids.save
    redirect_to bids_path
  else
    render 'new'
  end
  end



  def destroy
    @bids = Bid.find(params[:id])
    @bids.destroy
    redirect_to bids_path
  end

  def show
    @bids = Bid.find(params[:id])
    # @bid = Bid.new
  end


  private
  def bid_params
    params.require(:bid).permit(:amount, :bidders)
  end

  def is_admin
    unless  current_user && current_user.has_role?(:admin)
      redirect_to auctions_path
    end

  end

end

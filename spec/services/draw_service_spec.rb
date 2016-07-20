require 'rails_helper'

describe DrawService do
  let(:draw_service) { DrawService.new(auction) }
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:user_three) { create(:user) }
  let!(:admin) { create(:admin) }
  let(:auction) { create(:auction) }

  describe '#call' do
    context 'without enough bidders' do
      before { draw_service.enough_bids? }
      it { expect(draw_service.enough_bids?).to eq(false) }
    end
  end

  context 'with enough bidders' do
    before do
      auction.users << user_one
      auction.users << user_two
      auction.users << user_three
    end

    it { expect(draw_service.enough_bids?).to eq(true) }
  end

  context 'can start draw' do
    before do
      auction.users << user_one
      auction.users << user_two
      auction.users << user_three
      draw_service.call
    end

    it { expect(auction.users).to include(auction.winner) }
  end

  # describe '#enough_bids?' do
  #   let!(:bidder) { auction.users.create(user: user_one) }
  #   let!(:bidder_two) { auction.users.create(user: user_two) }
  #   before { draw_service.enough_bids? }
  #   context 'with two bidders' do
  #     it { expect([user_, user_two]).to include(auction.users) }
  #   end
  # end
  #

  # describe '#shuffle_winner' do
end

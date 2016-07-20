require 'rails_helper'

describe DrawService do
  let(:draw_service) { DrawService.new(auction) }
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:user_three) { create(:user) }
  let!(:admin) { create(:admin) }
  let(:auction) { create(:auction) }

  describe '#call' do
    context 'can start draw' do
      before do
        auction.users << user_one
        auction.users << user_two
        auction.users << user_three
        draw_service.call
      end

      it { expect(auction.users).to include(auction.winner) }
    end
  end
end

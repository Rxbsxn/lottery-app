require 'rails_helper'
RSpec.describe DrawService, type: :service do
  let(:draw_service) { DrawService.new(auction) }
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:user_three) { create(:user) }
  let!(:admin) { create(:admin) }
  let(:auction) { create(:auction) }

  describe '#enough_bids?' do
    before { sign_in admin }
    let!(:bidder) { auction.users.create(user: user_one) }
    let!(:bidder_two) { auction.users.create(user: user_two) }
    before { draw_service.enough_bids? }
    context 'with two bidders' do
      it { expect([bidder, bidder_two]).to include(auction.user) }
    end
  end

  describe '#shuffle_winner' do
    let!(:bidder) { auction.users.create(user: user_one) }
    let!(:bidder_two) { auction.users.create(user: user_two) }
    
  end
end
# let(:item) { create(:item) }
# +    let(:draw_winner) { DrawWinner.new(item) }
# +    let(:user1) { create(:user) }
# +    let(:user2) { create(:user) }
# +    let!(:bid1) { item.bids.create(user: user1) }
# +    let!(:bid2) { item.bids.create(user: user2) }
# +    before { draw_winner.rand_winner }
# +
# +    it { expect([user1, user2]).to include(item.user) }

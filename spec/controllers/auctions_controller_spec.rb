require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }
  let(:auction) { create(:auction) }
  describe '#index' do
    let!(:auctions) { create_list(:auction, 6).sort_by(&:name) }

    context 'first page' do
      before { get :index }
      it { expect(response).to render_template(:index) }
      it { expect(controller.auctions).to contain_exactly(*auctions[0..5]) }
    end

    context 'search by name' do
      let!(:auction) { create(:auction, name: 'random auction name') }
      before { get :index, params: { q: { name_cont: 'random auction name' } } }
      it { expect(controller.auctions).to contain_exactly(auction) }
    end
  end
  describe '#show' do
    let(:call_request) { get :show, params: { id: auction } }
    it_behaves_like 'an action rendering view'
  end

  describe '#create' do
    let(:attributes) { attributes_for(:auction) }
    let(:call_request) { post :create, auction: attributes }
    context 'no session' do
      it_behaves_like 'an action creating object', expect_failure: true
    end
    context 'regular user' do
      before { sign_in user }
      it_behaves_like 'an action creating object', expect_failure: true
    end
    context 'admin' do
      before { sign_in admin }
      it_behaves_like 'an action creating object'
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: auction }
    context 'no session' do
      it_behaves_like 'an action destroying object', expect_failure: true
    end

    context 'regular user' do
      before { sign_in user }
      it_behaves_like 'an action destroying object', expect_failure: true
    end

    context 'as admin' do
      before { sign_in admin }
      it_behaves_like 'an action destroying object'
    end
  end

  describe '#draw' do
    let(:call_request) { post :draw, params: { id: auction } }

    context 'user sign in as admin' do
      let!(:session) { sign_in admin }
      before { auction.users << user << create(:user) }

      it { expect { call_request }.to change { auction.reload.winner }.from(nil) }
      it_behaves_like 'an action redirecting to', -> { auction_path(auction) }
    end
    context 'user sign in as regular user' do
      before { sign_in user }
      it { expect { call_request }.to_not change { auction.reload.winner } }
      it_behaves_like 'an action redirecting to', -> { auctions_path }
    end
  end

  describe '#bid' do
    let(:call_request) { post :bid, params: { id: auction } }

    context 'user sign in' do
      let!(:session) { sign_in user }
      it { expect { call_request }.to change { auction.users.count }.from(0).to(1) }
      it_behaves_like 'an action redirecting to', -> { auction_path(auction) }
    end

    context 'user no sign in' do
      it { expect { call_request }.to_not change { auction.users.count } }
      it_behaves_like 'an action redirecting to', -> { '/users/sign_in' }
    end
  end
end

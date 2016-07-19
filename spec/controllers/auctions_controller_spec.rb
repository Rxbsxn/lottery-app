require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  describe '#index' do
    let!(:auctions) { create_list(:auction, 6).sort_by(&:name) }

    context 'first page' do
      before { get :index }
      it { expect(response).to render_template(:index) }
      it { expect(assigns[:auctions]).to contain_exactly(*auctions[0..5]) }
    end
    context 'search by name' do
      let(:auction) { create(:auction, name: 'random auction name') }
      before { get :index, params: { q: { name_cont: 'random auction name' } } }
      it { expect(assigns[:auctions]).to contain_exactly(auction) }
    end
  end
  describe '#show' do
    let(:auction) { create(:auction) }
    let(:call_request) { get :show, params: { id: auction.id } }
    it_behaves_like 'an action rendering view'
  end

  describe '#create', :focus do
    context 'user sign in' do
      let!(:session) { sign_in user }
      let(:attributes) { attributes_for(:auction) }
      let(:call_request) { post :create, auction: attributes }
      it_behaves_like 'an action creating object', [:name, :content]
    end
    context 'user no sign in' do
      it_behaves_like 'an action redirect_to', -> { '/users/sign_in'}
    end
  end

  describe '#destroy' do
    let!(:auction) { create(:auction) }
    let!(:admin) { create(:admin) }
    let(:call_request) { delete :destroy, id: auction.id }
    it_behaves_like 'an action destroying object' do
      let(:object) { :admin }
    end
  end

  describe '#update' do
    let!(:auction) { create(:auction)}
    let(:attributes) { auction_params(:auction)}
    let(:call_request) { patch :update, id: auction.id, auction: attributes }
    it_behaves_like 'an action updating object', [:name, :content]
  end

  describe '#bid' do
    let!(:user) { create(:user) }
    let(:auction) { create(:auction) }
    let(:call_request) { post :bid, params: { id: auction.id } }

    context 'user sign in' do
      let!(:session) { sign_in user }
      it { expect { call_request }.to change { auction.users.count }.from(0).to(1) }
      it_behaves_like 'an action redirecting to', -> { "/auctions/#{auction.id}" }
    end
    context 'user no sign in' do
      it { expect { call_request }.to_not change { auction.users.count } }
      it_behaves_like 'an action redirecting to', -> { '/users/sign_in' }
    end
  end
end

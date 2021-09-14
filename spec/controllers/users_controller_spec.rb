# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  before do
    sign_in user
  end

  describe 'GET index' do
    let(:user) { create(:user, :admin) }
    let(:users) { [user] }

    it 'renders index page' do
      get :index

      expect(assigns(:users)).to eq(users)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    let(:advertisement) { create(:advertisement, user: user) }
    let(:advertisements) { [advertisement] }
    let(:user) { create(:user, :admin) }

    it 'renders show page' do
      get :show, params: { id: user.id }

      expect(assigns(:user)).to eq(user)
      expect(assigns(:advertisements)).to eq(advertisements)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET edit' do
    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'renders edit page' do
        get :edit, params: { id: user.id }

        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'renders edit page' do
        get :edit, params: { id: user.id }

        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PATCH update' do
    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      context 'when updating herself' do
        let(:first_name) { 'Joe' }

        it 'updates user' do
          patch :update, params: { id: user.id, user: { first_name: first_name } }
          expect(user.reload.first_name).to eq first_name
          expect(response).to redirect_to(action: :show, id: assigns(:user).id)
        end
      end

      context 'when updating different user' do
        let(:different_user) { create(:user, :user) }

        it 'makes user an admin' do
          patch :update, params: { id: different_user.id, user: { admin: '1' } }
          expect(different_user.reload.admin?).to be true
          expect(response).to redirect_to(action: :show, id: assigns(:user).id)
        end
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }
      let(:first_name) { different_user.first_name }
      let(:different_user) { create(:user, :user) }

      it 'can update herself' do
        patch :update, params: { id: user.id, user: { first_name: first_name } }
        expect(user.reload.first_name).to eq first_name
        expect(response).to redirect_to(action: :show, id: assigns(:user).id)
      end

      it 'cannot update different user' do
        patch :update, params: { id: different_user.id, user: { first_name: 'Joe' } }
        expect(different_user.reload.first_name).to eq first_name
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'destroy user' do
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'destroy user' do
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
  end
end

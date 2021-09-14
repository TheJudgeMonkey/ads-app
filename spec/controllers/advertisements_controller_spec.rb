# frozen_string_literal: true

require 'rails_helper'

describe AdvertisementsController do
  describe 'GET index' do
    let(:advertisement) { create(:advertisement, :published) }
    let(:advertisements) { [advertisement] }

    before do
      advertisements
    end

    it 'renders index page' do
      get :index

      expect(assigns(:advertisements)).to eq(advertisements)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    let(:advertisement) { create(:advertisement) }

    it 'renders show page' do
      get :show, params: { id: advertisement.id }

      expect(assigns(:advertisement)).to eq(advertisement)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    before do
      sign_in user
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'renders new page' do
        get :new

        expect(assigns(:advertisement)).to be_a_new(Advertisement)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'redirects to root page' do
        get :new

        expect(assigns(:advertisement)).to be_a_new(Advertisement)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST create' do
    let(:category) { create(:category) }

    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'does not create advertisement' do
        expect do
          post :create,
               params: { advertisement: { title: 'Titile', description: 'Description', category_id: category.id } }
        end.not_to change(Advertisement, :count)
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }
      let(:advertisement_params) do
        {
          advertisement: {
            title: 'Titile',
            description: 'Description',
            category_id: category.id,
            draft: '1'
          }
        }
      end

      context 'when params are valid' do
        it 'create advertisement' do
          expect do
            post :create, params: advertisement_params
          end.to change(Advertisement, :count).by(1)
          expect(response).to redirect_to(action: :show, id: assigns(:advertisement).id)
        end
      end

      context 'when params are not valid' do
        let(:advertisement_params) do
          {
            advertisement: {
              title: '',
              description: 'Description',
              category_id: category.id,
              draft: '1'
            }
          }
        end

        it 'does not create advertisement' do
          expect do
            post :create, params: advertisement_params
          end.not_to change(Advertisement, :count)
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET edit' do
    let(:advertisement) { create(:advertisement) }

    before do
      sign_in user
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'renders edit page' do
        get :edit, params: { id: advertisement.id }

        expect(assigns(:advertisement)).to eq(advertisement)
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'does not render edit page' do
        get :edit, params: { id: advertisement.id }

        expect(assigns(:advertisement)).to eq(advertisement)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'PATCH update' do
    let(:category) { create(:category) }

    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:advertisement_title) { 'Sport' }
      let(:user) { create(:user, :admin) }
      let(:advertisement) { create(:advertisement, :draft) }

      it 'does not update advertisement' do
        patch :update, params: { id: advertisement.id, advertisement: { title: advertisement_title } }

        expect(advertisement).not_to eq advertisement_title
        expect(response).to redirect_to root_path
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      context 'when updating her own advertisement' do
        let(:advertisement) { create(:advertisement, :draft, user: user) }

        context 'when params are valid' do
          let(:expected_title) { 'Sport' }
          let(:advertisement_params) do
            {
              id: advertisement.id,
              advertisement: {
                title: expected_title,
                description: 'Description',
                category_id: category.id,
                draft: '1'
              }
            }
          end

          it 'updates advertisement' do
            patch :update, params: advertisement_params
            expect(advertisement.reload.title).to eq expected_title
            expect(response).to redirect_to(action: :show, id: advertisement.id)
          end
        end

        context 'when params are not valid' do
          it 'does not update advertisement' do
            patch :update, params: { id: advertisement.id, advertisement: { title: '' } }
            expect(assigns(:advertisement).errors.count).to eq(1)
            expect(response).to render_template(:edit)
          end
        end
      end

      context "when updating other user's advertisement" do
        let(:advertisement) { create(:advertisement, :draft, title: advertisement_title) }
        let(:advertisement_title) { 'Flowers' }
        let(:new_advertisement_title) { 'Sport' }

        it 'does not update advertisement' do
          patch :update, params: { id: advertisement.id, advertisement: { title: new_advertisement_title } }

          expect(advertisement.reload.title).to eq advertisement_title
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      sign_in user
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      context 'when user is deleting her own advertisement' do
        let(:advertisement) { create(:advertisement, user: user) }

        before do
          advertisement
        end

        it 'destroys advertisement' do
          expect do
            delete :destroy, params: { id: advertisement.id }
          end.to change(Advertisement, :count).by(-1)
          expect(response).to redirect_to advertisements_path
        end
      end

      context "when user is deleting other user's advertisement" do
        let(:advertisement) { create(:advertisement) }

        before do
          advertisement
        end

        it 'does not delete advertisement' do
          expect do
            delete :destroy, params: { id: advertisement.id }
          end.not_to change(Advertisement, :count)
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }
      let(:advertisement) { create(:advertisement) }

      before do
        advertisement
      end

      it 'destroys advertisement' do
        expect do
          delete :destroy, params: { id: advertisement.id }
        end.to change(Advertisement, :count).by(-1)
        expect(response).to redirect_to advertisements_path
      end
    end
  end
end

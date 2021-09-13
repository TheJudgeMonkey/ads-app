# frozen_string_literal: true

require 'rails_helper'

describe CategoriesController do
  let(:category) { create(:category) }
  let(:categories) { [category] }

  describe 'GET index' do
    before do
      categories
    end

    it 'renders index page' do
      get :index

      expect(assigns(:categories)).to eq(categories)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    let(:other_category_advertisement) { create(:advertisement, :published) }
    let(:published_advertisement) { create(:advertisement, :published, category: category) }
    let(:draft_advertisement) { create(:advertisement, :draft, category: category) }
    let(:expected_advertisements) { [published_advertisement] }

    before do
      other_category_advertisement
      published_advertisement
      draft_advertisement
    end

    it 'renders show page' do
      get :show, params: { id: category.id }

      expect(assigns(:category)).to eq(category)
      expect(assigns(:advertisements)).to eq(expected_advertisements)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'renders new page' do
        get :new

        expect(assigns(:category)).to be_a_new(Category)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'redirects to root page' do
        get :new

        expect(assigns(:category)).to be_a_new(Category)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST create' do
    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      context 'when params are valid' do
        it 'creates category' do
          expect do
            post :create, params: { category: { name: 'Travel' } }
          end.to change(Category, :count).by(1)
          expect(response).to redirect_to categories_path
        end
      end

      context 'when params are not valid' do
        it 'does not create category' do
          expect do
            post :create, params: { category: { name: '' } }
          end.not_to change(Category, :count)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'does not create category' do
        expect do
          post :create, params: { category: { name: 'Travel' } }
        end.not_to change(Category, :count)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET edit' do
    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'renders edit page' do
        get :edit, params: { id: category.id }

        expect(assigns(:category)).to eq(category)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'does not render edit page' do
        get :edit, params: { id: category.id }

        expect(assigns(:category)).to eq(category)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'PATCH update' do
    before do
      sign_in user
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      context 'when params are valid' do
        let(:expected_name) { 'Sport' }

        it 'updates category' do
          patch :update, params: { id: category.id, category: { name: expected_name } }

          expect(category.reload.name).to eq expected_name
          expect(response).to redirect_to categories_path
        end
      end

      context 'when params are not valid' do
        it 'does not update category' do
          patch :update, params: { id: category.id, category: { name: '' } }

          expect(assigns(:category).errors.count).to eq(1)
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }
      let(:category_name) { 'Sport' }

      it 'does not update category' do
        patch :update, params: { id: category.id, category: { name: category_name } }

        expect(category).not_to eq category_name
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      sign_in user
      category
    end

    context 'when user is admin' do
      let(:user) { create(:user, :admin) }

      it 'destroys category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.to change(Category, :count).by(-1)
        expect(response).to redirect_to categories_path
      end

      context 'when category has advertisements' do
        let(:advertisement) { create(:advertisement, category: category) }

        before do
          advertisement
        end

        it 'does not destroy category' do
          expect do
            delete :destroy, params: { id: category.id }
          end.not_to change(Category, :count)
          expect(flash.alert).to eq(I18n.t('categories.destroy.alert'))
          expect(response).to redirect_to categories_path
        end
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user, :user) }

      it 'does not destroy category' do
        expect do
          delete :destroy, params: { id: category.id }
        end.not_to change(Category, :count)
        expect(response).to redirect_to root_path
      end
    end
  end
end

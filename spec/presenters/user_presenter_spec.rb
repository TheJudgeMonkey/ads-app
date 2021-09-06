# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/presenters/user_presenter'

describe UserPresenter do
  subject(:user_presenter) { described_class.new(user) }

  let(:user) { build_stubbed(:user, :admin, first_name: first_name, last_name: last_name) }
  let(:first_name) { 'John' }
  let(:last_name) { 'Doe' }

  its(:first_name) { is_expected.to eq user.first_name }
  its(:last_name) { is_expected.to eq user.last_name }
  its(:id) { is_expected.to eq user.id }
  its(:email) { is_expected.to eq user.email }

  describe '#display_name' do
    context 'when first name is present and last name is not present' do
      let(:first_name) { 'John' }
      let(:last_name) { nil }

      it 'returns first name' do
        expect(user_presenter.display_name).to eq user.first_name
      end
    end

    context 'when last name is present and first name is not present' do
      let(:first_name) { nil }
      let(:last_name) { 'Doe' }

      it 'returns last name' do
        expect(user_presenter.display_name).to eq user.last_name
      end
    end

    context 'when first name and last name are present' do
      let(:first_name) { 'John' }
      let(:last_name) { 'Doe' }

      it 'returns first and last names' do
        expect(user_presenter.display_name).to eq "#{user.first_name} #{user.last_name}"
      end
    end

    context 'when first name and last name are not present' do
      let(:first_name) { nil }
      let(:last_name) { nil }

      it 'returns email' do
        expect(user_presenter.display_name).to eq user.email
      end
    end
  end
end

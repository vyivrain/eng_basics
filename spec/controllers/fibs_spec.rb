# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::FibsController, type: :controller do
  context '#index' do
    let!(:fib1) { create(:fib, items: [1, 1, 2]) }
    let!(:fib2) { create(:fib, items: [0, 1, 1, 2]) }

    it 'can view fibs' do
      get :index
      resp = JSON.parse(response.body).map(&:symbolize_keys)
      result = [{ id: fib1.id, items_str: fib1.items.to_s, known_fib_square: fib1.known_fibs_sum_of_squares,
                  created_at_format: fib1.created_at.strftime('%d-%m-%y %H:%M')},
                { id: fib2.id, items_str: fib2.items.to_s, known_fib_square: fib2.known_fibs_sum_of_squares,
                  created_at_format: fib2.created_at.strftime('%d-%m-%y %H:%M')}]
      expect(resp).to eq(result)
    end
  end

  context '#show' do
    let!(:fib) { create(:fib) }

    it 'can view fib' do
      get :show, params: { id: fib.id }
      resp = JSON.parse(response.body).symbolize_keys
      result = { id: fib.id, items_str: fib.items.to_s, known_fib_square: fib.known_fibs_sum_of_squares,
                 created_at_format: fib.created_at.strftime('%d-%m-%y %H:%M') }
      expect(resp).to eq(result)
    end
  end

  context '#check_item_exist' do
    context 'exists' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2, 3]) }

      it 'return success flash' do
        get :check_item_exist, params: { id: fib.id, fib: { number: 2 } }
        result = JSON.parse(response.body)
        expect(result['message']).to eq(I18n.t('fibs.check_items_exist.success'))
      end
    end

    context 'doesnt exist' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2, 3]) }

      it 'return success flash' do
        get :check_item_exist, params: { id: fib.id, fib: { number: 10 } }
        result = JSON.parse(response.body)
        expect(result['message']).to eq(I18n.t('fibs.check_items_exist.error'))
      end
    end
  end

  context '#check_items_equality' do
    context 'equals' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2, 3]) }

      it 'return success flash' do
        get :check_items_equality, params: { id: fib.id, fib: { list: '0, 1, 1, 2, 3' } }
        result = JSON.parse(response.body)
        expect(result['message']).to eq(I18n.t('fibs.check_items_equality.success'))
      end
    end

    context 'not equal' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2, 3, 5]) }

      it 'return success flash' do
        get :check_items_equality, params: { id: fib.id, fib: { list: '0, 1, 1, 2, 3' } }
        result = JSON.parse(response.body)
        expect(result['message']).to have_content(I18n.t('fibs.check_items_equality.error'))
      end
    end
  end
end

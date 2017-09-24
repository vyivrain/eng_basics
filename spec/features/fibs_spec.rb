# frozen_string_literal: true

require 'rails_helper'

describe 'Fibs', type: :feature, js: true do
  context '#index' do
    let!(:fib1) { create(:fib) }
    let!(:fib2) { create(:fib) }

    it 'can view fibs' do
      visit root_path
      expect(page).to have_content(fib1.items.to_s)
      expect(page).to have_content(fib2.items.to_s)
    end
  end

  context '#show' do
    let!(:fib) { create(:fib) }

    it 'can view fib' do
      visit fib_path(fib)
      expect(page).to have_content(fib.items.to_s)
      expect(page).to have_content(fib.known_fibs_sum_of_squares)
    end
  end

  context '#new' do
    context 'correctly' do
      it 'can create fib' do
        visit new_fib_path

        within '[data-fibs="new"]' do
          fill_in 'fib[number]', with: 5
          click_button 'Create'
        end

        expect(page).to have_content(I18n.t('fibs.create.success'))
        fib = Fib.last
        expect(fib.items).to eq([0, 1, 1, 2, 3])
      end
    end

    context 'Duplicate' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2]) }

      it 'cant create fib' do
        visit new_fib_path

        within '[data-fibs="new"]' do
          fill_in 'fib[number]', with: 4
          click_button 'Create'
        end

        expect(page).to have_content('Items has already been taken')
      end
    end
  end

  context '#destroy' do
    let!(:fib) { create(:fib) }

    it 'can destroy fib' do
      visit root_path
      page.accept_confirm do
        click_link 'Delete'
      end
    end
  end

  context '#check_item_exist' do
    context 'exists' do
      let!(:fib) { create(:fib) }

      it 'return success flash' do
        visit fib_path(fib)
        within '[data-fib="exist"]' do
          fill_in 'fib[number]', with: 1
          click_button 'Check'
        end

        expect(page).to have_content(I18n.t('fibs.check_items_exist.success'))
      end
    end

    context 'doesnt exist' do
      let!(:fib) { create(:fib) }

      it 'return success flash' do
        visit fib_path(fib)
        within '[data-fib="exist"]' do
          fill_in 'fib[number]', with: 19
          click_button 'Check'
        end

        expect(page).to have_content(I18n.t('fibs.check_items_exist.error'))
      end
    end
  end

  context '#check_items_equality' do
    context 'equals' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2, 3, 5]) }

      it 'return success flash' do
        visit fib_path(fib)
        within '[data-fib="equal"]' do
          fill_in 'fib[list]', with: '0, 1, 1, 2, 3, 5'
          click_button 'Check'
        end

        expect(page).to have_content(I18n.t('fibs.check_items_equality.success'))
      end
    end

    context 'not equal' do
      let!(:fib) { create(:fib, items: [0, 1, 1, 2, 3, 5]) }

      it 'return success flash' do
        visit fib_path(fib)
        within '[data-fib="equal"]' do
          fill_in 'fib[list]', with: '0, 1, 2, 3, 4, 5'
          click_button 'Check'
        end

        expect(page).to have_content(I18n.t('fibs.check_items_equality.error'))
      end
    end
  end

  context 'redirect' do
    it 'can if no fib found' do
      visit fib_path(id: 5)
      expect(current_path).to eq(root_path)
    end
  end
end
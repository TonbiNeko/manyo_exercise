require 'rails_helper'

RSpec.describe 'セッション機能', type: :system do

  describe 'ユーザーログイン' do
    let!(:user) { FactoryBot.create(:user) }
    context 'ユーザーがログインした場合' do
      it 'ユーサーの詳細ページにいく' do
        visit new_session_path
        fill_in 'session[email]', with: 'factorybot1@example.com'
        fill_in 'session[password]', with: 'factorybot'
        click_on 'Log in'
        expect(page).to have_content 'factorybot1@example.com'
      end
    end
  end
  describe '不正なアクセス' do
    context '一般ユーザが他人の詳細画面にアクセスした場合' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:second_user) { FactoryBot.create(:second_user, id: 1) }
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'factorybot1@example.com'
        fill_in 'session[password]', with: 'factorybot'
        click_on 'Log in'
        visit user_path(1)
      end
      it 'タスク一覧画面に遷移する' do
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
  describe 'ユーザーログアウト' do
    context 'ユーザーがログアウトした場合' do
      let!(:user) { FactoryBot.create(:user) }
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'factorybot1@example.com'
        fill_in 'session[password]', with: 'factorybot'
        click_on 'Log in'
        click_link 'Log out'
      end
      it 'ログインページへ遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
end

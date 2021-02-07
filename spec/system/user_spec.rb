require 'rails_helper'

RSpec.describe 'ユーザーと管理ユーザー', type: :system do

  describe 'ユーザーの新規登録' do
    context 'ユーザーが新規登録した場合' do
      it 'ユーサーの詳細ページにいく' do
        visit new_user_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'Create my account'
        expect(page).to have_content 'testのページ'
      end
    end
  end
  describe 'ユーザログイン' do
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
end

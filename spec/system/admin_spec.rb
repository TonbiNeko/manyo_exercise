require 'rails_helper'

RSpec.describe '管理ユーザー', type: :system do

  describe '管理ユーザー' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin) { FactoryBot.create(:admin) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'admin@example.com'
      fill_in 'session[password]', with: 'factorybot'
      click_on 'Log in'
    end
    context '管理ユーザが管理画面にアクセスした場合' do
      it 'ユーザー管理画面にいく' do
        expect(page).to have_content 'ユーザー一覧'
      end
    end
    context '管理ユーザがユーザの新規登録をした場合' do
      it '新規ユーザーが作成される' do
        click_on '新しくユーザーを作成する'
        fill_in 'user[name]', with: 'user_test'
        fill_in 'user[email]', with: 'user_test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'ユーザーの作成'
        expect(page).to have_content 'user_testのページ'
      end
    end
    context '管理ユーザが一般ユーザの詳細画面にアクセスした場合' do
      it '一般ユーザの詳細画面に遷移される' do
        click_on '詳細',match: :first
        expect(page).to have_content 'factorybotさん詳細ページ'
      end
    end
    context '管理ユーザがユーザの編集画面からユーザを編集した場合' do
      it '一般ユーザの情報が編集される' do
        click_on '編集',match: :first
        fill_in 'user[name]', with: 'edited'
        fill_in 'user[email]', with: 'edited@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        sleep(3)
        click_on 'factorybotさんのアカウント情報を更新'
        expect(page).to have_content 'editedさん詳細ページ' && 'edited@example.com'
      end
    end
    context '管理ユーザがユーザを削除した場合' do
      it '一般ユーザは情報が削除される' do
        click_on '削除',match: :first
        page.driver.browser.switch_to.alert.accept
        sleep(3)
        expect(page).not_to have_content 'factorybot'
      end
    end
  end
  describe '一般ユーザー' do
    context '一般ユーザが管理画面にアクセスにした場合' do
      let!(:user) { FactoryBot.create(:user) }
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'factorybot@example.com'
        fill_in 'session[password]', with: 'factorybot'
        click_on 'Log in'
      end
      it 'タスク一覧ページに遷移する' do
        visit admin_users_path
        expect(page).to have_content 'タスク一覧' && '管理者以外アクセス出来ません'
      end
    end
  end
end

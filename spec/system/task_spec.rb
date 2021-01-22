require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in "task[name]", with: 'タスク１'
      fill_in "task[description]", with: '内容１'
      click_button '登録'
      expect(page).to have_content 'タスク１'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'Factoryで作ったデフォルトのname1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # task_list = all('.task_name')
        # first_task_name = task_list.first.text

        actual_task_names = all('.task_name').map(&:text)

        # expected_task_names = [
        #   'Factoryで作ったデフォルトのname2',
        #   'Factoryで作ったデフォルトのname1'
        # ]

        expected_task_names = Task.all.order(created_at: :desc).pluck(:name)

        expect(actual_task_names).to eq expected_task_names

        # expect(first_task_name).to include 'Factoryで作ったデフォルトのname2'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:second_task)
        visit tasks_path
        click_on '詳細'
        expect(page).to have_content 'Factoryで作ったデフォルトのdescriotion2'
       end
     end
  end
end
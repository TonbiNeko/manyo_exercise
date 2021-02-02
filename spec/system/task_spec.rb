require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in "task[name]", with: 'タスク１'
      fill_in "task[description]", with: '内容１'
      fill_in "task[expiration_date]", with: '2021/01/01'
      select "完了", from: "task[status]"
      click_button '登録'
      expect(page).to have_content 'タスク１'
      end
    end
    context 'タスクを新規登録する時' do
      it 'ステータスも登録ができる' do
      visit new_task_path
      fill_in "task[name]", with: 'タスク2'
      fill_in "task[description]", with: '内容2'
      fill_in "task[expiration_date]", with: '2020/02/02'
      select "完了", from: "task[status]"
      click_button '登録'
      expect(page).to have_content '完了'
      end
    end
    context 'タスクを新規登録する時' do
      it '終了期限も登録できる' do
      visit new_task_path
      fill_in "task[name]", with: 'タスク3'
      fill_in "task[description]", with: '内容3'
      page.execute_script("document.getElementById('task_expiration_date').value = '2021-02-02'")
      select "完了", from: "task[status]"
      click_button '登録'
      expect(page).to have_content '2021-02-02'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) {FactoryBot.create(:third_task) }
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

  describe 'ソート機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) {FactoryBot.create(:third_task) }
    before do
      visit tasks_path
    end
    context 'タスクが終了期限でソートする場合' do
      it '終了期限の降順に並ぶ' do
        click_on "終了期限でソート"
        actual_task_names = all('.task_name').map(&:text)
        expected_task_names = Task.all.order(expiration_date: :desc).pluck(:name)
        expect(actual_task_names).to eq expected_task_names
      end
    end
    context 'タスクが優先順位でソートする場合' do
      it '優先順位（高→中→低）に並ぶ' do
        click_on "優先順位でソート"
        sleep(2)
        actual_task_names = all('.task_name').map(&:text)
        expected_task_names = Task.all.sort_priority.map(&:name)
        expect(actual_task_names).to eq expected_task_names
      end
    end
    context 'タスクが優先順位でソートする場合' do
      it 'ステータス（未着手→着手中→完了）で日付が早い順に並ぶ' do
        click_on "日付とステータスでソート"
        sleep(2)
        actual_task_names = all('.task_name').map(&:text)
        expected_task_names = Task.all.sort_date_and_status.map(&:name)
        expect(actual_task_names).to eq expected_task_names
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

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, name: "task", status: "完了") }
    let!(:second_task) { FactoryBot.create(:second_task, name: "sample", status: "完了") }
    let!(:third_task) { FactoryBot.create(:third_task, name: "sample2", status: "完了") }
    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in "name", with: "task"
        click_on "検索", match: :first
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select "完了", from: "status"
        find('#status').click
        expect(page).to have_content "task" && "完了"
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "name", with: "sample"
        select "完了", from: "status"
        find('#status').click
        expect(page).to have_content "sample" && "sample2" && "完了"
      end
    end
  end
end
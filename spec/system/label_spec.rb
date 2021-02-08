require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do

  def login
    visit new_session_path
    fill_in 'session[email]', with: 'factorybot2@example.com'
    fill_in 'session[password]', with: 'factorybot'
    click_on 'Log in'
  end

  def create_labels
    label = FactoryBot.create(:label)
    label2 = FactoryBot.create(:second_label)
    label3 = FactoryBot.create(:third_label)
  end

  before do
    user = FactoryBot.create(:second_user)
    create_labels
    login

    FactoryBot.create(:task, name: "test_task1", description: "description for test_task1", expiration_date: Time.zone.today + 3, status: Task::statuses['未着手'], priority: Task::priorities['高'], user: user)
    FactoryBot.create(:task, name: "test_task2", description: "description for test_task2", expiration_date: Time.zone.today + 5, status: Task::statuses['着手中'], priority: Task::priorities['中'], user: user)
    FactoryBot.create(:task, name: "test_task3", description: "description for test_task3", expiration_date: Time.zone.today + 10, status: Task::statuses['完了'], priority: Task::priorities['低'], user: user)

  end

  describe 'ラベル機能' do
    # let!(:second_user) { FactoryBot.create(:second_user) }
    # let!(:label) { FactoryBot.create(:label) }
    # let!(:second_label) { FactoryBot.create(:second_label) }
    # let!(:third_label) { FactoryBot.create(:third_label) }
    # let!(:task) { FactoryBot.create(:task) }
    # let!(:second_task) { FactoryBot.create(:second_task) }
    
    # before do
    #   login
    # end

    context 'ユーザーがタスクを新規登録した場合' do
      it 'ラベルも一緒に登録できる' do

        visit new_task_path
        fill_in "task[name]", with: 'タスク１'
        fill_in "task[description]", with: '内容１'
        fill_in "task[expiration_date]", with: '2021/01/01'
        select "完了", from: "task[status]"
        select "高", from: "task[priority]"
        check 'task[label_ids][]', match: :first
        click_button '登録'
        expect(page).to have_content "Factory_label1"
      end
    end
    
    context 'ユーザーがタスクを編集した場合' do
      let!(:task) { FactoryBot.create(:task, :task_with_groups) }
      it 'ラベルも編集できる' do
        visit tasks_path
        all('td')[16].click_link
        check 'task[label_ids][]', match: :first
        click_button '登録'
        all('td')[15].click_link
        sleep(3)
        expect(page).to have_content "Factory_label1"
      end
    end

    context 'ユーザーがタスクを消去した場合' do
      let!(:task) { FactoryBot.create(:task, :task_with_groups) }
      it 'ラベルも消去できる' do
        visit tasks_path
        all('td')[8].click_link
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'Factoryで作ったデフォルトのname1'
      end
    end
  end

  describe 'ラベル検索機能' do
    context 'ユーザーラベル検索したとき' do
      let!(:task) { FactoryBot.create(:task, :task_with_groups) }
      it '該当のラベルのタスクのみ表示される' do
        visit tasks_path
        select 'Factory_label1', from: 'label_id', match: :first
        click_on '検索'
        expect(page).to have_content 'Factory_label1'
      end
    end
  end
end
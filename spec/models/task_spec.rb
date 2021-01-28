require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', description: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト２',description: '')
        task.valid?
        expect(task.errors[:description].to_s).to include("入力してください")
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テストname',description: '成功テストdescription', expiration_date: '2020-01-30', status: '完了')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, name: 'task', status: "完了") }
    let!(:second_task) { FactoryBot.create(:second_task, name: "sample", status: "完了") }
    let!(:third_task) { FactoryBot.create(:third_task, name: "sample2", status: "未着手") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_with_name('task')).to include(task)
        expect(Task.search_with_name('task')).not_to include(second_task)
        expect(Task.search_with_name('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_with_status('完了')).to include(task)
        expect(Task.search_with_status('完了')).not_to include(third_task)
        expect(Task.search_with_status('未着手').count).to eq 1
        expect(Task.search_with_status('完了').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect_task = Task.search_with_name('task').search_with_status('完了')
        expect(expect_task.count).to eq 1
        expect_task = Task.search_with_name('sample').search_with_status('完了')
        expect(expect_task.count).to eq 1
        expect_task = Task.search_with_name('sample').search_with_status('完')
        expect(expect_task.count).to eq 0 
      end
    end
  end
end
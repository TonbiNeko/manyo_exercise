FactoryBot.define do
  factory :task_label do
    task_id { Task.last.id }
    label_id { Label.last.id }
  end
end

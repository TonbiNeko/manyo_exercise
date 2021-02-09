FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったデフォルトのname1' }
    description { 'Factoryで作ったデフォルトのdescription1' }
    expiration_date { 'Fri, 01 Jan 2021' }
    status { 0 }
    priority { 0 }
    association :user
    
    # trait :task_with_groups do
    #   after(:build) do |task|
    #     label = create(:label)
    #     task.task_labels << build(:task_label, label: label)
    #   end
    trait :task_with_groups do
      after(:create) do |task|
        #label = FactoryBot.create(:label)
        task.task_labels << FactoryBot.create(:task_label)
        task.save
      end
    end

    # after(:build) do |task|
    #   label = Factorybot.create(:label, name: "test")
    #   task.task_labels << Factorybot.create(:task_label, label: label)
    # end
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのname2' }
    description { 'Factoryで作ったデフォルトのdescriotion2' }
    expiration_date { 'Tue, 02 Feb 2021' }
    status { 1 }
    priority { 1 }
    association :user, factory: :second_user
  end
  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのname3' }
    description { 'Factoryで作ったデフォルトのdescriotion3' }
    expiration_date { 'Wed, 03 Mar 2021' }
    status { 2 }
    priority { 2 }
    association :user, factory: :third_user
  end
end
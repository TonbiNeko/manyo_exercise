FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったデフォルトのname1' }
    description { 'Factoryで作ったデフォルトのdescription1' }
  end
  factory :second_task, class: Task do
    name { 'factoryで作ったデフォルトのname2' }
    description { 'Factoryで作ったデフォルトのdescriotion2' }
  end
end
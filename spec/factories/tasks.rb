FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったデフォルトのname1' }
    description { 'Factoryで作ったデフォルトのdescription1' }
    expiration_date { 'Fri, 01 Jan 2021' }
    status { 0 }
    priority { 0 }
    user_id { 1 }
    association :user
  end
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのname2' }
    description { 'Factoryで作ったデフォルトのdescriotion2' }
    expiration_date { 'Tue, 02 Feb 2021' }
    status { 1 }
    priority { 1 }
    user_id { 2 }
    association :user, factory: :second_user
  end
  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのname3' }
    description { 'Factoryで作ったデフォルトのdescriotion3' }
    expiration_date { 'Wed, 03 Mar 2021' }
    status { 2 }
    priority { 2 }
    user_id { 3 }
    association :user, factory: :third_user
  end
end
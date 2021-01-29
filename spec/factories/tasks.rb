FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったデフォルトのname1' }
    description { 'Factoryで作ったデフォルトのdescription1' }
    expiration_date { 'Fri, 01 Jan 2021' }
    status { 0 }
  end
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのname2' }
    description { 'Factoryで作ったデフォルトのdescriotion2' }
    expiration_date { 'Tue, 02 Feb 2021' }
    status { 1 }
  end
  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのname3' }
    description { 'Factoryで作ったデフォルトのdescriotion3' }
    expiration_date { 'Wed, 03 Mar 2021' }
    status { 2 }
  end
end
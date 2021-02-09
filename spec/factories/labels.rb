FactoryBot.define do
  factory :label do
    name { 'Factory_label1' }
  end
  factory :second_label, class: Label do
    name { 'Factory_label2' }
  end
  factory :third_label, class: Label do
    name { 'Factory_label3' }
  end
end

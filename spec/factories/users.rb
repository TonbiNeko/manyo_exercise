FactoryBot.define do
  factory :user do
    name { "factorybot" }
    email { "factorybot@example.com" }
    password { "factorybot" }
    password_confirmation{ "factorybot" }
    admin { false }
  end
  factory :second_user, class: User do
    name { "factorybot1" }
    email { "factorybot1@example.com" }
    password { "factorybot" }
    password_confirmation { "factorybot" }
    admin { false }
  end
  factory :third_user, class: User do
    name { "factorybot2" }
    email { "factorybot2@example.com" }
    password { "factorybot" }
    password_confirmation { "factorybot" }
    admin { false }
  end
  factory :admin, class: User do
    name { "admin" }
    email { "admin@example.com" }
    password { "factorybot" }
    password_confirmation { "factorybot" }
    admin { true }
  end
end

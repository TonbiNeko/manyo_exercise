# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

label_1 = Label.create!(name: "sample_label-1")
label_2 = Label.create!(name: "sample_label-2")
label_3 = Label.create!(name: "sample_label-3")
label_4 = Label.create!(name: "sample_label-4")
label_5 = Label.create!(name: "sample_label-5")
label_6 = Label.create!(name: "sample_label-6")
label_7 = Label.create!(name: "sample_label-7")
label_8 = Label.create!(name: "sample_label-8")
label_9 = Label.create!(name: "sample_label-9")
label_10 = Label.create!(name: "sample_label-10")
label_11 = Label.create!(name: "sample_label-11")

10.times do |i|
  User.create!(
    name: "sample#{i + 1}",
    email: "sample#{i + 1}@example.com",
    password: "password",
    password_confirmation: "password",
    admin: false)
end

10.times do |i|
  Task.create!(
    name: "sample_task#{i + 1}",
    description: "sample_description#{i + 1}",
    expiration_date: Time.zone.today + (i + 1),
    status: 0,
    priority: 0,
    user_id: User.first.id,
    label_ids: [(label_1.id + i + 1).to_s ]
  )
end

# label = Label.create!(name: "sample_label")

# user = User.create!(
#       name: "heyhey5",
#       email: "heyhey5@example.com",
#       password: "password",
#       password_confirmation: "password",
#       admin: false
# )

# task = Task.create!(
#       name: "heyhey5",
#       description: "heyhey5",
#       expiration_date: Time.zone.today,
#       status: 0,
#       priority: 0,
#       user_id: user.id,
#       label_ids: [label.id.to_s]
# )

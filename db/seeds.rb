10.times do |n|
  name  = "Thien#{n+1}"
  email = "thien#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

20.times do |n|
  name  = "Category #{n}"
  description = "Description-#{n}"
  Category.create!(name:  name,
               description: description,
               created_at: Time.zone.now)
end

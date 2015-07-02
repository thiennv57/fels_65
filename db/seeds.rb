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

10.times do |n|
  name  = "Category #{n}"
  description = "Description-#{n}"
  Category.create!(name:  name,
               description: description,
               created_at: Time.zone.now)
end

categories = Category.all

5.times do |n|
  word = "English#{n+1}"
  categories.each {|category| category.words.create! word: word}
end

words = Word.order(:created_at).all

3.times do
  words.each do |word|
    mean = "Vietnam"
    word.answers.create mean: mean
  end
end

words.each do |word|
  mean = "Vietnamese"
  word.answers.create mean: mean, is_correct: true
end


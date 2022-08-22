# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Category.destroy_all
Recipe.destroy_all
Ingredient.destroy_all

2.times do
  User.create!(email: Faker::Internet.email, password: "123456")
end

3.times do
  Category.create!(description: Faker::Food.ethnic_category)
end

Category.all.each do |category|
  20.times do
    recipe = category.recipes.create!(
      title: Faker::Food.dish,
      descriptions: Faker::Food.description,
      time: rand(5.minutes..2.hours).to_s,
      difficulty: rand(0..2),
      user: User.all.sample,
    )
    
    rand(2..4).times do
      recipe.ingredients.create!(unit: rand(0..3), amount: rand(0.5..100.0))
    end
  end
end

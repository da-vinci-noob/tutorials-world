# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

languages = %w[Ruby\ on\ Rails JavaScript VueJS ReactJS HTML CSS]

others = %w[VSCode TailwindCSS Git]

languages.each { |language| Language.create(title: language, others: false) }

others.each { |other| Language.create(title: other, others: true) }

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.create(name: "Jeff Shirt", description: "Why does it have Channing Tatum's face all over it", 
size: "extra_large", colour: "blue", image_link: "", price: 69.0, purchases_count: 2, 
stock_count: 2, arrival_date: nil) 
Item.create(name: "Reuben Shirt", description: "Brown for the indian vibes", size: "small", colour: "brown", 
image_link: "", price: 33.0, purchases_count: 3, stock_count: 10, arrival_date: nil) 

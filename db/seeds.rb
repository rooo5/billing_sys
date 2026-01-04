# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.create!([
  { name: "Pen", product_code: "P001", stock: 100, price: 10, tax_percentage: 5 },
  { name: "Notebook", product_code: "P002", stock: 50, price: 50, tax_percentage: 12 },
  { name: "Bag", product_code: "P003", stock: 20, price: 500, tax_percentage: 18 }
])

Denomination.create!([
  { value: 500, available_count: 10 },
  { value: 50, available_count: 20 },
  { value: 20, available_count: 30 },
  { value: 10, available_count: 50 },
  { value: 5, available_count: 100 },
  { value: 2, available_count: 100 },
  { value: 1, available_count: 100 }
])
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# frozen_string_literal: true

require 'ffaker'

def generate_user
  user = User.new(email: FFaker::Internet.email, password: FFaker::Internet.password)
  user.skip_confirmation!
  user.save!
end

def generate_admin
  user = User.new(email: 'admin@admin.com', password: 'addmine')
  user[:role_name] = 'admin'
  user.skip_confirmation!
  user.save!
end

def generate_categories
  ['Mobile Development', 'Web design', 'Web Development', 'Photo'].map do |category|
    Category.new(name: category).save!
  end
end

def generate_materials
  %w(Bones Leather Wood Iron Paper).each do |material|
    Material.new(name: material).save!
  end
end

def generate_author
  Author.new(name: FFaker::Name.first_name, surname: FFaker::Name.last_name).save!
end

def generate_book
  Book.new(
    name: FFaker::Book.title,
    description: FFaker::Book.description(8),
    price: rand(0.02...99.99),
    publication_year: rand(1001...2017),
    authors: Author.order("random()").first(2),
    materials: Material.order("random()").first(2),
    category: Category.order("random()").first
  ).save!
end

def generate_dimensions_for_books
  Book.all.each do |book|
    BookDimension.new(
      height: rand(0.50...20.00),
      width: rand(0.50...20.00),
      depth: rand(0.50...20.00),
      book: book
    ).save!
  end
end

def generate_coupons(custom_coupon = nil)
  Coupon.create!(
    code: custom_coupon ? custom_coupon : SecureRandom.hex(4).upcase,
    discount: rand(1...10)
  )
end

def generate_delivery
  Delivery.create!(
    price: rand(1...15),
    title: FFaker::Lorem.word,
    optimistic_days: rand(1...3),
    pesimistic_days: rand(4...7)
  )
end

5.times { generate_user }
generate_categories
generate_materials
15.times { generate_author }
100.times { generate_book }
generate_dimensions_for_books
10.times { generate_coupons }
4.times { generate_delivery }

generate_admin
generate_coupons('00000')

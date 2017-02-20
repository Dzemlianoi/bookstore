require 'ffaker'

def generate_users
  5.times do |_|
    password = FFaker::Internet.password
    user = User.new(
        email:                  FFaker::Internet.email,
        password:               password,
        password_confirmation:  password,
    )
    user.skip_confirmation!
    user.save!
  end

  admin = User.new(
      email:                  'admin@test.com',
      password:               'adminpassword',
      password_confirmation:  'adminpassword',
      role_name:              'admin'
  )

  admin.skip_confirmation!
  admin.save!
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
      description: FFaker::Book.description,
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

def generate_coupons
  Coupon.create!(
    code: SecureRandom.hex(4).upcase,
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

generate_users
generate_categories
generate_materials
15.times{ generate_author }
100.times{ generate_book }
generate_dimensions_for_books
20.times { generate_coupons }
4.times { generate_delivery }

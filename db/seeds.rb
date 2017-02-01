require 'ffaker'

def generateUsers
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

def generateCategories
  ['Mobile Development', 'Web design', 'Web Development', 'Photo'].map do |category|
    Category.new(name: category).save!
  end
end

def generateAuthors
  5.times do |_|
    Author.new(name: FFaker::Name.first_name, surname: FFaker::Name.last_name).save!
  end
end

def generateBooks
  25.times do ||
    Book.new(
        name: FFaker::Book.title,
        description: FFaker::Book.description,
        price: rand(0.02...99.99),
        quantity: rand(1...6),
        publication_year: rand(1001...2017),
        height: rand(0.50...20.00),
        width: rand(0.50...20.00),
        depth: rand(0.50...20.00),
        author: Author.order("random()").first,
        category: Category.order("random()").first
    ).save!
  end
end

generateUsers
generateCategories
generateAuthors
generateBooks
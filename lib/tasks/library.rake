namespace :library do
  desc "Seed data"
  task seed_data: :environment do
    %w(db:drop db:create db:migrate).each do |task|
      Rake::Task[task].invoke
    end

    User.create! name: "Hai Ninh", email: "haininh@gmail.com", password: "12345678", password_confirmation: "12345678"
    User.create! name: "Van Hai", email: "haivan@gmail.com", password: "123456789", password_confirmation: "123456789"
    categories = [
      {name: "History", parent_id: nil},
      {name: "Literature & Fiction", parent_id: nil},
      {name: "Sci-Fi & Fantasy", parent_id: nil},
      {name: "Business", parent_id: nil},
      {name: "Science & Math", parent_id: nil},
      {name: "African", parent_id: 1},
      {name: "Asian", parent_id: 1},
      {name: "Ancient", parent_id: 1},
      {name: "Classics", parent_id: 2},
      {name: "Anthologies", parent_id: 2},
      {name: "Economics", parent_id: 4},
      {name: "Industries", parent_id: 4},
      {name: "International", parent_id: 4},
      {name: "Astronomy", parent_id: 5},
      {name: "Animals", parent_id: 5},
      {name: "Biology", parent_id: 5},
      {name: "Action", parent_id: 3},
      {name: "Coming of Age", parent_id: 3},
      {name: "Dark Fantasy", parent_id: 3}
    ]

    categories.each do |category|
      Category.create! category
    end

    authors = [
      {name: "Dalai Lama XIV"},
      {name: "Howard C. Cutler"},
      {name: "Ishmael Beah"},
      {name: "Jared Diamond"},
      {name: "F. Scott Fitzgerald"}
    ]

    authors.each do |author|
      Author.create! author
    end

    publishers = [
      {name: "Riverhead Books"},
      {name: "Sarah Crichton Books"},
      {name: "Viking Press"},
      {name: "Charles Scribner's Sons"}
    ]

    publishers.each do |publisher|
      Publisher.create! publisher
    end

    books = [
      {name: "The Art of Happiness : A Handbook for Living",
       author_books_attributes: [{author_id: 3}],
       category_books_attributes: [{category_id: 1}, {category_id: 7}],
       publisher_id: 1,
       total_pages: 731, quantity: 100,
       image: "https://images-na.ssl-images-amazon.com/images/I/51OVhhkMZqL._SX320_BO1,204,203,200_.jpg",
       description: FFaker::Lorem.paragraph},
      {name: "Long Way Gone Memoirs of a Boy Soldier",
       author_books_attributes: [{author_id: 1}, {author_id: 2}],
       category_books_attributes: [{category_id: 1}, {category_id: 8}],
       publisher_id: 2,
       total_pages: 240, quantity: 100,
       description: FFaker::Lorem.paragraph,
       image: "https://i5.walmartimages.com/asr/c53f6fed-2643-487c-9bdd-925a434a1070_1.1bfb6b28b847f9b8c8c8ca71ffb8a0e9.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF}",
      {name: "Collapse",
       author_books_attributes: [{author_id: 4}],
       category_books_attributes: [{category_id: 2}, {category_id: 9}],
       publisher_id: 3,
       total_pages: 240, quantity: 100,
       description: FFaker::Lorem.paragraph,
       image: "https://gerakbudayapenang.com/wp-content/uploads/2016/01/collapse-300x0.jpg"},
      {name: "The Great Gatsby",
       author_books_attributes: [{author_id: 5}],
       category_books_attributes: [{category_id: 2}, {category_id: 10}],
       publisher_id: 4,
       total_pages: 180, quantity: 100,
       description: FFaker::Lorem.paragraph,
       image: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/
       TheGreatGatsby_1925jacket.jpeg/220px-TheGreatGatsby_1925jacket.jpeg"}
    ]
    books.each do |book|
      Book.create! book
    end

    User.all.each{|user| user.borrows.create! start_date: Time.now + 1.days, end_date: Time.now + 7.days, approve: true}

    book_borrows = [
      {
        borrow_id: 1,
        book_id: 1
      },
      {
        borrow_id: 1,
        book_id: 2
      },
      {
        borrow_id: 1,
        book_id: 3
      },
      {
        borrow_id: 2,
        book_id: 1
      },
      {
        borrow_id: 2,
        book_id: 4
      },
      {
        borrow_id: 2,
        book_id: 2
      }
    ]
    book_borrows.each do |book_borrow|
      BookBorrow.create! book_borrow
    end
  end
  task faker_comment: :environment do
    user = User.create! name: "haiha", email: FFaker::Internet.email,
      password: "123456"
    10.times do |_n|
      name = FFaker::Name.name
      email = FFaker::Internet.email
      password = "123456"
      user = User.create! name: name, email: email, password: password
      user.skip_confirmation!
    end
    users = User.order(:created_at).take(10)
    users.each do |user|
      Book.take(10).each do |book|
        book.comments.build(user_id: user.id,
        content: FFaker::Lorem.paragraph).save
      end
    end
  end
end

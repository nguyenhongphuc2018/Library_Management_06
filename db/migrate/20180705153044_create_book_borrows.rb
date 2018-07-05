class CreateBookBorrows < ActiveRecord::Migration[5.1]
  def change
    create_table :book_borrows do |t|
      t.datetime :return_date
      t.references :borrow, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end

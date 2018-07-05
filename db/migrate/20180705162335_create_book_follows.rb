class CreateBookFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :book_follows do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end

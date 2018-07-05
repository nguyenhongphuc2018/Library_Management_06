class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :total_pages
      t.integer :quantity
      t.text :description
      t.string :image
      t.references :publisher, foreign_key: true

      t.timestamps
    end
  end
end

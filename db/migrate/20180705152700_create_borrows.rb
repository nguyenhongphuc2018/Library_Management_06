class CreateBorrows < ActiveRecord::Migration[5.1]
  def change
    create_table :borrows do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :approve, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateAuthorFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :author_follows do |t|
      t.references :user, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end

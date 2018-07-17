class AddAvgRateToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :avg_rate, :float, default: 0
  end
end

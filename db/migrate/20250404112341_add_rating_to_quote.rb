class AddRatingToQuote < ActiveRecord::Migration[8.0]
  def change
    add_column :quotes, :rating, :integer
  end
end

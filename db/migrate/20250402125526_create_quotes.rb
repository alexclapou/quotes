# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :quotes do |t|
      t.string :content, null: false

      t.timestamps
    end
  end
end

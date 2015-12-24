class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :company, index: true
    	t.references :portfolio, index: true
      t.string :type
      t.integer :quantity
      t.float :price
      t.float :total_price

      t.timestamps
    end
  end
end

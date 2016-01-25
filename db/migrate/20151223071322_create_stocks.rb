class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :company, index: true
    	t.references :portfolio, index: true
      t.string :type
      t.integer :quantity, default: 0
      t.float :price, default: 0
      t.float :total_price, default: 0

      t.timestamps
    end
  end
end

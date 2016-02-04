class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :cik_code
      t.integer :sic_code
      t.string :free_code
      t.string :premium_code
      t.float :current_price, default: 0.0
      t.string :city
      t.string :state
      t.string :symbol
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end

class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :cik_code
      t.integer :sic_code
      t.string :city
      t.string :state
      t.string :symbol
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end

class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :firm_id
      t.string :city
      t.string :state
      t.string :symbol
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

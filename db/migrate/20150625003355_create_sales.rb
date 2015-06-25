class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :portfolio, index: true
      t.integer :firm_id
      t.string :type
      t.integer :quantity
      t.float :value

      t.timestamps
    end
  end
end

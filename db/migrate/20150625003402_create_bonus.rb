class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus do |t|
      t.references :portfolio, index: true
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end

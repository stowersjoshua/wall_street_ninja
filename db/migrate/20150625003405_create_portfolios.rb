class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.float :balance
      t.boolean :active, default: false 
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end

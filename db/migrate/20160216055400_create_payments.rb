class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true, foreign_key: true
    	t.references :plan, index: true, foreign_key: true
    	t.float :amount, default: 0.0
    	t.string :status, default: "success"
    	t.integer :transaction_id
    	t.integer :subscription_id

      t.timestamps
    end
  end
end
